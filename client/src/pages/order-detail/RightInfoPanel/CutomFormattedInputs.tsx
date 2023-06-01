/* eslint-disable react-hooks/exhaustive-deps */
/** @jsxImportSource @emotion/react */
import React from 'react'
import NumberFormat, { InputAttributes } from 'react-number-format'

export interface CustomProps {
  onChange: (event: { target: { name: string; value: string } }) => void
  name: string
}

export const DateFormatCustom = React.forwardRef<NumberFormat<InputAttributes>, CustomProps>(
  function NumberFormatCustom(props, ref) {
    const { onChange, ...other } = props

    return (
      <NumberFormat
        {...other}
        getInputRef={ref}
        onValueChange={values => {
          onChange({
            target: {
              name: props.name,
              value: values.value
            }
          })
        }}
        format="##.##.##"
      />
    )
  }
)

export const MoneyFormatCustom = React.forwardRef<NumberFormat<InputAttributes>, CustomProps>(
  function NumberFormatCustom(props, ref) {
    const { onChange, ...other } = props

    return (
      <NumberFormat
        {...other}
        getInputRef={ref}
        onValueChange={values => {
          onChange({
            target: {
              name: props.name,
              value: values.value
            }
          })
        }}
        prefix={'₽ '}
        thousandSeparator={true}
      />
    )
  }
)
