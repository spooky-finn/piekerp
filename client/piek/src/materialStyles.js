export const muicomponents = (theme) => ({
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
        disableRipple: true,
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
})