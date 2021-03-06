{-# LANGUAGE TemplateHaskell #-}

module PeaCoq where

import           Control.Lens
import qualified Data.IntMap as IM
import           Snap
import           Snap.Snaplet.Session (SessionManager)
import           System.IO
import           System.Process

data PeaCoq
  = PeaCoq
    { _lSession :: Snaplet SessionManager
    }

makeLenses ''PeaCoq

data SessionState
  = SessionState
    Int              -- an identifier for the session
    Bool             -- True while the session is alive
    (Handle, Handle) -- I/O handles
    ProcessHandle    -- useful to kill the process

data GlobalState
  = GlobalState
    Int                      -- next session number
    (IM.IntMap SessionState) -- active sessions
    (Maybe String)           -- user name
    String                   -- commit number
