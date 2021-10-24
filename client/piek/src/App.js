import { useContext } from 'react';
import { Context } from './index';

// import ReactTooltip from 'react-tooltip';
import {observer} from 'mobx-react-lite';

import BaseLayout from './components/BaseLayout';
import Sidebar from './components/Sidebar/Sidebar';

import { createTheme, ThemeProvider } from '@mui/material/styles';


let theme = createTheme({
  palette: {
    mode: 'light',
    primary: {
      main: '#3763FE',
      light: '#E7E9FB',
    },
    secondary: {
      main: '#e5534b',
    }
  },
  typography: {
    subtitle1: {
      fontSize: '.9rem',
      fontFamily: "IBM PLEX MONO"
    }
  },
});

theme = createTheme(theme, {
  components: {
    MuiDialog: {
      styleOverrides: {
        paper: {
          borderRadius: 'var(--br) !important',
        }
      }
    },
    MuiDialogTitle: {
      styleOverrides: {
        root: {
          color: theme.palette.text.primary,
        }
      }
    },

    MuiMenuItem: {
      styleOverrides: {
        root: {
          fontSize: '.8rem'
        }
      },
      defaultProps: {
        disableRipple: true
      }
    },
    MuiButton: {
      styleOverrides: {
        root: {
          fontSize: '.8rem',
          textTransform: 'none !important',
        },
        textInfo: {
          color: 'var(--lowContrast) !important',
        },
      },
      defaultProps: {
        disableElevation: true,
        disableRipple: true, // No more ripple!
      },
    },

    MuiTextField: {
      defaultProps: {
        variant: 'standard'
      }
    },
    MuiInputLabel: {
      styleOverrides: {
        root: {
          color: 'var(--lowContrast) !important',
        }
      },
      defaultProps: {
        shrink: true,
      }
    },
    MuiFilledInput: {
      defaultProps: {
        disableUnderline: 'true',
        size: 'small',
      },
      styleOverrides: {
        root: {
          background: 'var(--L1)',
          border: '1px solid var(--borderLight)',
          borderRadius: '10px',
          ':hover': {
            background: 'var(--L1)',
          },
        },

      }
    },
    MuiInput: {
      defaultProps: {
        disableUnderline: 'true'
      }
    },
    MuiInputBase: {
      styleOverrides: {
        root: {
          color: 'var(--highContrast) !important',
        }
      }
    },
    MuiOutlinedInput: {
      styleOverrides: {
        notchedOutline: {
          border: 'none',
        }
      }
    },
    MuiPopover: {
      styleOverrides: {
        paper: {
          background: 'var(--L0)',
          borderRadius: 'var(--br) !important'
        }
      }
    },
    MuiSelect: {
      styleOverrides: {
        select: {
          fontSize: '.8rem',
          boxSizing: 'border-box',
          border: 'none !important',
          outline: 'none !important',
          boxShadow: 'none !important',
          padding: 0,
        }
      }
    },
    MuiTab: {
      defaultProps: {
        disableRipple: true
      }
    },
    MuiCheckbox: {
      defaultProps: {
        disableRipple: true
      }
    }
  },
});
// overrides: {
//   MuiInputLabel: {
//     root: {
//       color: 'var(--lowContrast)',
//       fontSize: '.8rem',
//     },
//   },
//   MuiButton: {
//     root: {
//       textTransform: 'none',
//       boxShadow: 'none !important',
//     }
//   },
//   MuiOutlinedInput: {
//     notchedOutline: {
//       borderColor: 'var(--border)',
//     },
//     focused:{
//       borderColor: 'var(--border) !important',
//     }
//   },
//   MuiInputBase: {
//     root: {
//       borderBottom: 'none',
//       color: 'var(--highContrast)',
//       '&::before': {
//         borderColor: 'var(--border) !important',
//       }
//     },
//   },
//   MuiIconButton:{
//     root: {
//       color: 'var(--lowContrast)',
//       opacity: .5
//     }
//   },
//   MuiAutocomplete: {
//     paper: {
//       background: 'var(--L0) !important',
//       border: '1px solid var(--border)',
//     },
//     listbox: {
//       color: 'var(--highContrast)',
//       fontSize: '.8rem',
//     },
//   },
// },

function App() {  
  const { store } = useContext(Context);
  return (
    <ThemeProvider theme={theme}>
      <div className="App">
        
        { store.inMemoryToken && <Sidebar/> }

          <BaseLayout/>
        
      </div>
    </ThemeProvider>

  );
}

export default observer(App);
