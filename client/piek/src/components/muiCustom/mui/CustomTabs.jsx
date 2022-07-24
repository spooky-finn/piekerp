/** @jsxImportSource @emotion/react */
import { css } from '@emotion/react'
import PropTypes from 'prop-types';
import { motion } from 'framer-motion';
import { Tabs, Tab, Box } from '@mui/material';
import { styled } from '@mui/material/styles';

const StyledTabs = styled((props) => <Tabs {...props} TabIndicatorProps={{
    style: {
        display: "none",
    },
}} />)(
    ({ theme }) => ({
        background: 'var(--LI)',
        minHeight: '10px',
    }),
);

const StyledTab = styled((props) => <Tab {...props} />)(
    ({ theme }) => ({
        textTransform: 'none',
        fontWeight: 500,
        fontSize: theme.typography.pxToRem(14),
        borderRight: '1px solid transparent',
        borderLeft: '1px solid transparent',
        minHeight: '10px',
        color: 'var(--lowContrast)',
        '&.Mui-selected': {
            boxShadow: '0 0 15px 0px var(--shadow-color)',
            opacity: 1,
            backgroundColor: 'var(--L0)',
            color: 'var(--accent) !important',
            borderRight: 'var(--border)',
            borderLeft: 'var(--border)',
        },
        '&:first-of-type': {
            borderLeft: 'none !important',
        },
        '&.Mui-selected:first-of-type': {
            borderLeft: 'none !important',
        }
    }),
);


const CustomTabs = ({ value, onChange, tabs, children }) => {

    function TabPanel(props) {
        const { children, value, index, ...other } = props;

        return (
            <div
                {...other}
            >
                {value === index && (
                    <Box mb='30px'>{children}</Box>
                )}
            </div>
        );
    }

    TabPanel.propTypes = {
        children: PropTypes.node,
        index: PropTypes.any.isRequired,
        value: PropTypes.any.isRequired,
    };

    function a11yProps(index) {
        return {
            id: `simple-tab-${index}`,
            'aria-controls': `simple-tabpanel-${index}`,
        };
    }

    return (
        <>
            <StyledTabs value={value} onChange={(e, newValue) => onChange(newValue)}>
                {tabs.map((each, index) => (
                    <StyledTab key={index} label={each.title} {...a11yProps(index)} />
                ))}

                <div css={css`
                    margin-left: auto;
                    display: flex;
                    align-items: center;
                    margin-right: 20px;
                `}>
                    {children}
                </div>

            </StyledTabs>

            {tabs.map((each, index) => (
                <TabPanel key={index} value={value} index={index}>
                    <motion.div
                    // initial={{ opacity: 0, scale: 1 }}
                    // animate={{ opacity: 1, scale: 1 }}
                    >
                        {each.component}
                    </motion.div>
                </TabPanel>
            ))}
        </>
    )
}
export default CustomTabs