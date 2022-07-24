const getPalette = (preferTheme) => ({
    palette: {
        preferTheme,
        ...(preferTheme === 'light'
            ? {
                // palette values for light preferTheme
                primary: {
                    main: '#4361e4',
                    light: '#E7E9FB',
                },
                secondary: {
                    main: '#e5534b',
                }
            }
            : {
                // palette values for dark preferTheme
                primary: {
                    main: '#99affc',
                    light: '#43435c',
                },
                secondary: {
                    main: '#e5534b',
                },

            }),
    },
    typography: {
        fontFamily: `-apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', 'Oxygen', 'Ubuntu', 'Cantarell', 'Fira Sans', 'Droid Sans', 'Helvetica Neue',sans-serif`,
        subtitle1: {
            // Акцентный подзаголовок
            fontSize: '.7rem',
            textTransform: 'uppercase',
            fontWeight: 600,
            letterSpacing: '.5px',
            color: 'var(--accent) !important',
        },
        subtitle2: {
            // Нейтральный подзаголовок
            fontWeight: 600,
            textTransform: 'uppercase',
            fontSize: '.65rem'
        },
        subtitle3: {
            // Полупрозрачный подзаголовок
            fontSize: '.7rem',
            color: 'var(--lowContrast) !important',
            textTransform: 'uppercase',
        }
    },
});

export default getPalette;