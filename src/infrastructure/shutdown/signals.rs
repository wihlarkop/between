use tokio::sync::oneshot;

/// Setup signal handlers for graceful shutdown
///
/// This function creates signal handlers for SIGTERM and SIGINT (Ctrl+C).
/// Returns a oneshot receiver that will fire when a shutdown signal is received.
pub fn setup_signal_handlers() -> oneshot::Receiver<()> {
    let (tx, rx) = oneshot::channel();

    tokio::spawn(async move {
        let ctrl_c = async {
            tokio::signal::ctrl_c()
                .await
                .expect("Failed to install Ctrl+C handler");
        };

        #[cfg(unix)]
        let terminate = async {
            tokio::signal::unix::signal(tokio::signal::unix::SignalKind::terminate())
                .expect("Failed to install SIGTERM handler")
                .recv()
                .await;
        };

        #[cfg(not(unix))]
        let terminate = std::future::pending::<()>();

        tokio::select! {
            _ = ctrl_c => {
                tracing::info!("Received SIGINT (Ctrl+C) signal");
            }
            _ = terminate => {
                tracing::info!("Received SIGTERM signal");
            }
        }

        let _ = tx.send(());
    });

    rx
}
