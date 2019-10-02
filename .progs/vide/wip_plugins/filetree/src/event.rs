/// Module defining all possible events we might receive from neovim

use neovim_lib::neovim_api::Buffer;

#[derive(Debug)]
pub enum Event {
    SubscribeBuf(Buffer, String),
    Shutdown,
    Search,
}
