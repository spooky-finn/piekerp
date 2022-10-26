import { useContext } from "react";
import { Context } from "../index";


export default function useAppContext() {
    return useContext(Context)
}