"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.getSdk = exports.AllUsersQueryDocument = exports.UpdateTokenMutationDocument = exports.DeleteTokenMutationDocument = exports.InsertTokenMutationDocument = exports.AllTokensQueryDocument = exports.UnpaidOrdersQueryDocument = exports.AllOrdersPaymentsDataQueryDocument = exports.DeleteDocsMutationDocument = exports.InsertDocsArrayMutationDocument = exports.Order_By = exports.Erp_Users_Update_Column = exports.Erp_Users_Select_Column = exports.Erp_Users_Constraint = exports.Erp_Tokens_Update_Column = exports.Erp_Tokens_Select_Column = exports.Erp_Tokens_Constraint = exports.Erp_PaymentHistory_Update_Column = exports.Erp_PaymentHistory_Select_Column = exports.Erp_PaymentHistory_Constraint = exports.Erp_Orders_Update_Column = exports.Erp_Orders_Select_Column = exports.Erp_Orders_Constraint = exports.Erp_OrderStatus_Update_Column = exports.Erp_OrderStatus_Select_Column = exports.Erp_OrderStatus_Constraint = exports.Erp_OrderItems_Update_Column = exports.Erp_OrderItems_Select_Column = exports.Erp_OrderItems_Constraint = exports.Erp_Notifications_Update_Column = exports.Erp_Notifications_Select_Column = exports.Erp_Notifications_Constraint = exports.Erp_Docs_Update_Column = exports.Erp_Docs_Select_Column = exports.Erp_Docs_Constraint = exports.Erp_Comments_Update_Column = exports.Erp_Comments_Select_Column = exports.Erp_Comments_Constraint = exports.Erp_AccessLevels_Update_Column = exports.Erp_AccessLevels_Select_Column = exports.Erp_AccessLevels_Constraint = exports.Attendance_Users_Update_Column = exports.Attendance_Users_Select_Column = exports.Attendance_Users_Constraint = exports.Attendance_Intervals_Update_Column = exports.Attendance_Intervals_Select_Column = exports.Attendance_Intervals_Constraint = exports.Attendance_Config_Update_Column = exports.Attendance_Config_Select_Column = exports.Attendance_Config_Constraint = void 0;
const graphql_tag_1 = __importDefault(require("graphql-tag"));
/** unique or primary key constraints on table "attendance.config" */
var Attendance_Config_Constraint;
(function (Attendance_Config_Constraint) {
    /** unique or primary key constraint */
    Attendance_Config_Constraint["ConfigPkey"] = "config_pkey";
})(Attendance_Config_Constraint = exports.Attendance_Config_Constraint || (exports.Attendance_Config_Constraint = {}));
/** select columns of table "attendance.config" */
var Attendance_Config_Select_Column;
(function (Attendance_Config_Select_Column) {
    /** column name */
    Attendance_Config_Select_Column["Id"] = "ID";
    /** column name */
    Attendance_Config_Select_Column["TimeDeduction"] = "TimeDeduction";
})(Attendance_Config_Select_Column = exports.Attendance_Config_Select_Column || (exports.Attendance_Config_Select_Column = {}));
/** update columns of table "attendance.config" */
var Attendance_Config_Update_Column;
(function (Attendance_Config_Update_Column) {
    /** column name */
    Attendance_Config_Update_Column["Id"] = "ID";
    /** column name */
    Attendance_Config_Update_Column["TimeDeduction"] = "TimeDeduction";
})(Attendance_Config_Update_Column = exports.Attendance_Config_Update_Column || (exports.Attendance_Config_Update_Column = {}));
/** unique or primary key constraints on table "attendance.intervals" */
var Attendance_Intervals_Constraint;
(function (Attendance_Intervals_Constraint) {
    /** unique or primary key constraint */
    Attendance_Intervals_Constraint["IntervalsPkey"] = "Intervals_pkey";
    /** unique or primary key constraint */
    Attendance_Intervals_Constraint["IntervalsIdKey"] = "intervals_id_key";
})(Attendance_Intervals_Constraint = exports.Attendance_Intervals_Constraint || (exports.Attendance_Intervals_Constraint = {}));
/** select columns of table "attendance.intervals" */
var Attendance_Intervals_Select_Column;
(function (Attendance_Intervals_Select_Column) {
    /** column name */
    Attendance_Intervals_Select_Column["Card"] = "card";
    /** column name */
    Attendance_Intervals_Select_Column["Database"] = "database";
    /** column name */
    Attendance_Intervals_Select_Column["Ent"] = "ent";
    /** column name */
    Attendance_Intervals_Select_Column["Ext"] = "ext";
    /** column name */
    Attendance_Intervals_Select_Column["Id"] = "id";
})(Attendance_Intervals_Select_Column = exports.Attendance_Intervals_Select_Column || (exports.Attendance_Intervals_Select_Column = {}));
/** update columns of table "attendance.intervals" */
var Attendance_Intervals_Update_Column;
(function (Attendance_Intervals_Update_Column) {
    /** column name */
    Attendance_Intervals_Update_Column["Card"] = "card";
    /** column name */
    Attendance_Intervals_Update_Column["Database"] = "database";
    /** column name */
    Attendance_Intervals_Update_Column["Ent"] = "ent";
    /** column name */
    Attendance_Intervals_Update_Column["Ext"] = "ext";
    /** column name */
    Attendance_Intervals_Update_Column["Id"] = "id";
})(Attendance_Intervals_Update_Column = exports.Attendance_Intervals_Update_Column || (exports.Attendance_Intervals_Update_Column = {}));
/** unique or primary key constraints on table "attendance.users" */
var Attendance_Users_Constraint;
(function (Attendance_Users_Constraint) {
    /** unique or primary key constraint */
    Attendance_Users_Constraint["UsersCardKey"] = "users_card_key";
    /** unique or primary key constraint */
    Attendance_Users_Constraint["UsersPkey"] = "users_pkey";
})(Attendance_Users_Constraint = exports.Attendance_Users_Constraint || (exports.Attendance_Users_Constraint = {}));
/** select columns of table "attendance.users" */
var Attendance_Users_Select_Column;
(function (Attendance_Users_Select_Column) {
    /** column name */
    Attendance_Users_Select_Column["Card"] = "card";
    /** column name */
    Attendance_Users_Select_Column["Firstname"] = "firstname";
    /** column name */
    Attendance_Users_Select_Column["Id"] = "id";
    /** column name */
    Attendance_Users_Select_Column["Lastname"] = "lastname";
})(Attendance_Users_Select_Column = exports.Attendance_Users_Select_Column || (exports.Attendance_Users_Select_Column = {}));
/** update columns of table "attendance.users" */
var Attendance_Users_Update_Column;
(function (Attendance_Users_Update_Column) {
    /** column name */
    Attendance_Users_Update_Column["Card"] = "card";
    /** column name */
    Attendance_Users_Update_Column["Firstname"] = "firstname";
    /** column name */
    Attendance_Users_Update_Column["Id"] = "id";
    /** column name */
    Attendance_Users_Update_Column["Lastname"] = "lastname";
})(Attendance_Users_Update_Column = exports.Attendance_Users_Update_Column || (exports.Attendance_Users_Update_Column = {}));
/** unique or primary key constraints on table "erp.AccessLevels" */
var Erp_AccessLevels_Constraint;
(function (Erp_AccessLevels_Constraint) {
    /** unique or primary key constraint */
    Erp_AccessLevels_Constraint["AccessLevelsPkey"] = "AccessLevels_pkey";
})(Erp_AccessLevels_Constraint = exports.Erp_AccessLevels_Constraint || (exports.Erp_AccessLevels_Constraint = {}));
/** select columns of table "erp.AccessLevels" */
var Erp_AccessLevels_Select_Column;
(function (Erp_AccessLevels_Select_Column) {
    /** column name */
    Erp_AccessLevels_Select_Column["AccessLevelId"] = "AccessLevelID";
    /** column name */
    Erp_AccessLevels_Select_Column["Name"] = "Name";
})(Erp_AccessLevels_Select_Column = exports.Erp_AccessLevels_Select_Column || (exports.Erp_AccessLevels_Select_Column = {}));
/** update columns of table "erp.AccessLevels" */
var Erp_AccessLevels_Update_Column;
(function (Erp_AccessLevels_Update_Column) {
    /** column name */
    Erp_AccessLevels_Update_Column["AccessLevelId"] = "AccessLevelID";
    /** column name */
    Erp_AccessLevels_Update_Column["Name"] = "Name";
})(Erp_AccessLevels_Update_Column = exports.Erp_AccessLevels_Update_Column || (exports.Erp_AccessLevels_Update_Column = {}));
/** unique or primary key constraints on table "erp.Comments" */
var Erp_Comments_Constraint;
(function (Erp_Comments_Constraint) {
    /** unique or primary key constraint */
    Erp_Comments_Constraint["CommentsPkey"] = "Comments_pkey";
})(Erp_Comments_Constraint = exports.Erp_Comments_Constraint || (exports.Erp_Comments_Constraint = {}));
/** select columns of table "erp.Comments" */
var Erp_Comments_Select_Column;
(function (Erp_Comments_Select_Column) {
    /** column name */
    Erp_Comments_Select_Column["CommentId"] = "CommentID";
    /** column name */
    Erp_Comments_Select_Column["OrderId"] = "OrderID";
    /** column name */
    Erp_Comments_Select_Column["Text"] = "Text";
    /** column name */
    Erp_Comments_Select_Column["Timestamp"] = "Timestamp";
    /** column name */
    Erp_Comments_Select_Column["UserId"] = "UserID";
})(Erp_Comments_Select_Column = exports.Erp_Comments_Select_Column || (exports.Erp_Comments_Select_Column = {}));
/** update columns of table "erp.Comments" */
var Erp_Comments_Update_Column;
(function (Erp_Comments_Update_Column) {
    /** column name */
    Erp_Comments_Update_Column["CommentId"] = "CommentID";
    /** column name */
    Erp_Comments_Update_Column["OrderId"] = "OrderID";
    /** column name */
    Erp_Comments_Update_Column["Text"] = "Text";
    /** column name */
    Erp_Comments_Update_Column["Timestamp"] = "Timestamp";
    /** column name */
    Erp_Comments_Update_Column["UserId"] = "UserID";
})(Erp_Comments_Update_Column = exports.Erp_Comments_Update_Column || (exports.Erp_Comments_Update_Column = {}));
/** unique or primary key constraints on table "erp.Docs" */
var Erp_Docs_Constraint;
(function (Erp_Docs_Constraint) {
    /** unique or primary key constraint */
    Erp_Docs_Constraint["DocsIdKey"] = "Docs_ID_key";
    /** unique or primary key constraint */
    Erp_Docs_Constraint["DocsKeyKey"] = "Docs_Key_key";
    /** unique or primary key constraint */
    Erp_Docs_Constraint["DocsPkey"] = "Docs_pkey";
})(Erp_Docs_Constraint = exports.Erp_Docs_Constraint || (exports.Erp_Docs_Constraint = {}));
/** select columns of table "erp.Docs" */
var Erp_Docs_Select_Column;
(function (Erp_Docs_Select_Column) {
    /** column name */
    Erp_Docs_Select_Column["FileName"] = "FileName";
    /** column name */
    Erp_Docs_Select_Column["Id"] = "ID";
    /** column name */
    Erp_Docs_Select_Column["Key"] = "Key";
    /** column name */
    Erp_Docs_Select_Column["OrderId"] = "OrderID";
    /** column name */
    Erp_Docs_Select_Column["Size"] = "Size";
    /** column name */
    Erp_Docs_Select_Column["UploadingDate"] = "UploadingDate";
})(Erp_Docs_Select_Column = exports.Erp_Docs_Select_Column || (exports.Erp_Docs_Select_Column = {}));
/** update columns of table "erp.Docs" */
var Erp_Docs_Update_Column;
(function (Erp_Docs_Update_Column) {
    /** column name */
    Erp_Docs_Update_Column["FileName"] = "FileName";
    /** column name */
    Erp_Docs_Update_Column["Id"] = "ID";
    /** column name */
    Erp_Docs_Update_Column["Key"] = "Key";
    /** column name */
    Erp_Docs_Update_Column["OrderId"] = "OrderID";
    /** column name */
    Erp_Docs_Update_Column["Size"] = "Size";
    /** column name */
    Erp_Docs_Update_Column["UploadingDate"] = "UploadingDate";
})(Erp_Docs_Update_Column = exports.Erp_Docs_Update_Column || (exports.Erp_Docs_Update_Column = {}));
/** unique or primary key constraints on table "erp.Notifications" */
var Erp_Notifications_Constraint;
(function (Erp_Notifications_Constraint) {
    /** unique or primary key constraint */
    Erp_Notifications_Constraint["NotificationsPkey"] = "Notifications_pkey";
})(Erp_Notifications_Constraint = exports.Erp_Notifications_Constraint || (exports.Erp_Notifications_Constraint = {}));
/** select columns of table "erp.Notifications" */
var Erp_Notifications_Select_Column;
(function (Erp_Notifications_Select_Column) {
    /** column name */
    Erp_Notifications_Select_Column["CommentId"] = "CommentID";
    /** column name */
    Erp_Notifications_Select_Column["Id"] = "ID";
    /** column name */
    Erp_Notifications_Select_Column["MentionedUser"] = "MentionedUser";
    /** column name */
    Erp_Notifications_Select_Column["OrderId"] = "OrderID";
    /** column name */
    Erp_Notifications_Select_Column["Viewed"] = "Viewed";
})(Erp_Notifications_Select_Column = exports.Erp_Notifications_Select_Column || (exports.Erp_Notifications_Select_Column = {}));
/** update columns of table "erp.Notifications" */
var Erp_Notifications_Update_Column;
(function (Erp_Notifications_Update_Column) {
    /** column name */
    Erp_Notifications_Update_Column["CommentId"] = "CommentID";
    /** column name */
    Erp_Notifications_Update_Column["Id"] = "ID";
    /** column name */
    Erp_Notifications_Update_Column["MentionedUser"] = "MentionedUser";
    /** column name */
    Erp_Notifications_Update_Column["OrderId"] = "OrderID";
    /** column name */
    Erp_Notifications_Update_Column["Viewed"] = "Viewed";
})(Erp_Notifications_Update_Column = exports.Erp_Notifications_Update_Column || (exports.Erp_Notifications_Update_Column = {}));
/** unique or primary key constraints on table "erp.OrderItems" */
var Erp_OrderItems_Constraint;
(function (Erp_OrderItems_Constraint) {
    /** unique or primary key constraint */
    Erp_OrderItems_Constraint["OrderItemsPkey"] = "OrderItems_pkey";
})(Erp_OrderItems_Constraint = exports.Erp_OrderItems_Constraint || (exports.Erp_OrderItems_Constraint = {}));
/** select columns of table "erp.OrderItems" */
var Erp_OrderItems_Select_Column;
(function (Erp_OrderItems_Select_Column) {
    /** column name */
    Erp_OrderItems_Select_Column["Fitter"] = "Fitter";
    /** column name */
    Erp_OrderItems_Select_Column["FullName"] = "FullName";
    /** column name */
    Erp_OrderItems_Select_Column["Name"] = "Name";
    /** column name */
    Erp_OrderItems_Select_Column["OrderId"] = "OrderID";
    /** column name */
    Erp_OrderItems_Select_Column["OrderItemId"] = "OrderItemID";
    /** column name */
    Erp_OrderItems_Select_Column["Quantity"] = "Quantity";
    /** column name */
    Erp_OrderItems_Select_Column["SerialEnds"] = "SerialEnds";
    /** column name */
    Erp_OrderItems_Select_Column["SerialStarts"] = "SerialStarts";
})(Erp_OrderItems_Select_Column = exports.Erp_OrderItems_Select_Column || (exports.Erp_OrderItems_Select_Column = {}));
/** update columns of table "erp.OrderItems" */
var Erp_OrderItems_Update_Column;
(function (Erp_OrderItems_Update_Column) {
    /** column name */
    Erp_OrderItems_Update_Column["Fitter"] = "Fitter";
    /** column name */
    Erp_OrderItems_Update_Column["FullName"] = "FullName";
    /** column name */
    Erp_OrderItems_Update_Column["Name"] = "Name";
    /** column name */
    Erp_OrderItems_Update_Column["OrderId"] = "OrderID";
    /** column name */
    Erp_OrderItems_Update_Column["OrderItemId"] = "OrderItemID";
    /** column name */
    Erp_OrderItems_Update_Column["Quantity"] = "Quantity";
    /** column name */
    Erp_OrderItems_Update_Column["SerialEnds"] = "SerialEnds";
    /** column name */
    Erp_OrderItems_Update_Column["SerialStarts"] = "SerialStarts";
})(Erp_OrderItems_Update_Column = exports.Erp_OrderItems_Update_Column || (exports.Erp_OrderItems_Update_Column = {}));
/** unique or primary key constraints on table "erp.OrderStatus" */
var Erp_OrderStatus_Constraint;
(function (Erp_OrderStatus_Constraint) {
    /** unique or primary key constraint */
    Erp_OrderStatus_Constraint["OrderStatusPkey"] = "OrderStatus_pkey";
})(Erp_OrderStatus_Constraint = exports.Erp_OrderStatus_Constraint || (exports.Erp_OrderStatus_Constraint = {}));
/** select columns of table "erp.OrderStatus" */
var Erp_OrderStatus_Select_Column;
(function (Erp_OrderStatus_Select_Column) {
    /** column name */
    Erp_OrderStatus_Select_Column["Id"] = "ID";
    /** column name */
    Erp_OrderStatus_Select_Column["Name"] = "Name";
})(Erp_OrderStatus_Select_Column = exports.Erp_OrderStatus_Select_Column || (exports.Erp_OrderStatus_Select_Column = {}));
/** update columns of table "erp.OrderStatus" */
var Erp_OrderStatus_Update_Column;
(function (Erp_OrderStatus_Update_Column) {
    /** column name */
    Erp_OrderStatus_Update_Column["Id"] = "ID";
    /** column name */
    Erp_OrderStatus_Update_Column["Name"] = "Name";
})(Erp_OrderStatus_Update_Column = exports.Erp_OrderStatus_Update_Column || (exports.Erp_OrderStatus_Update_Column = {}));
/** unique or primary key constraints on table "erp.Orders" */
var Erp_Orders_Constraint;
(function (Erp_Orders_Constraint) {
    /** unique or primary key constraint */
    Erp_Orders_Constraint["OrdersPkey"] = "Orders_pkey";
})(Erp_Orders_Constraint = exports.Erp_Orders_Constraint || (exports.Erp_Orders_Constraint = {}));
/** select columns of table "erp.Orders" */
var Erp_Orders_Select_Column;
(function (Erp_Orders_Select_Column) {
    /** column name */
    Erp_Orders_Select_Column["AcceptanceDate"] = "AcceptanceDate";
    /** column name */
    Erp_Orders_Select_Column["ActualShippingDate"] = "ActualShippingDate";
    /** column name */
    Erp_Orders_Select_Column["AwaitingDispatch"] = "AwaitingDispatch";
    /** column name */
    Erp_Orders_Select_Column["CheckListTplid"] = "CheckListTPLID";
    /** column name */
    Erp_Orders_Select_Column["City"] = "City";
    /** column name */
    Erp_Orders_Select_Column["Comment"] = "Comment";
    /** column name */
    Erp_Orders_Select_Column["CreatingDate"] = "CreatingDate";
    /** column name */
    Erp_Orders_Select_Column["Entity"] = "Entity";
    /** column name */
    Erp_Orders_Select_Column["InvoiceNumber"] = "InvoiceNumber";
    /** column name */
    Erp_Orders_Select_Column["IsReclamation"] = "IsReclamation";
    /** column name */
    Erp_Orders_Select_Column["ManagerId"] = "ManagerID";
    /** column name */
    Erp_Orders_Select_Column["NeedAttention"] = "NeedAttention";
    /** column name */
    Erp_Orders_Select_Column["OrderId"] = "OrderID";
    /** column name */
    Erp_Orders_Select_Column["OrderNumber"] = "OrderNumber";
    /** column name */
    Erp_Orders_Select_Column["OrderStatusId"] = "OrderStatusID";
    /** column name */
    Erp_Orders_Select_Column["PaidAmount"] = "PaidAmount";
    /** column name */
    Erp_Orders_Select_Column["ShippingDate"] = "ShippingDate";
    /** column name */
    Erp_Orders_Select_Column["TotalAmount"] = "TotalAmount";
})(Erp_Orders_Select_Column = exports.Erp_Orders_Select_Column || (exports.Erp_Orders_Select_Column = {}));
/** update columns of table "erp.Orders" */
var Erp_Orders_Update_Column;
(function (Erp_Orders_Update_Column) {
    /** column name */
    Erp_Orders_Update_Column["AcceptanceDate"] = "AcceptanceDate";
    /** column name */
    Erp_Orders_Update_Column["ActualShippingDate"] = "ActualShippingDate";
    /** column name */
    Erp_Orders_Update_Column["AwaitingDispatch"] = "AwaitingDispatch";
    /** column name */
    Erp_Orders_Update_Column["CheckListTplid"] = "CheckListTPLID";
    /** column name */
    Erp_Orders_Update_Column["City"] = "City";
    /** column name */
    Erp_Orders_Update_Column["Comment"] = "Comment";
    /** column name */
    Erp_Orders_Update_Column["CreatingDate"] = "CreatingDate";
    /** column name */
    Erp_Orders_Update_Column["Entity"] = "Entity";
    /** column name */
    Erp_Orders_Update_Column["InvoiceNumber"] = "InvoiceNumber";
    /** column name */
    Erp_Orders_Update_Column["IsReclamation"] = "IsReclamation";
    /** column name */
    Erp_Orders_Update_Column["ManagerId"] = "ManagerID";
    /** column name */
    Erp_Orders_Update_Column["NeedAttention"] = "NeedAttention";
    /** column name */
    Erp_Orders_Update_Column["OrderId"] = "OrderID";
    /** column name */
    Erp_Orders_Update_Column["OrderNumber"] = "OrderNumber";
    /** column name */
    Erp_Orders_Update_Column["OrderStatusId"] = "OrderStatusID";
    /** column name */
    Erp_Orders_Update_Column["PaidAmount"] = "PaidAmount";
    /** column name */
    Erp_Orders_Update_Column["ShippingDate"] = "ShippingDate";
    /** column name */
    Erp_Orders_Update_Column["TotalAmount"] = "TotalAmount";
})(Erp_Orders_Update_Column = exports.Erp_Orders_Update_Column || (exports.Erp_Orders_Update_Column = {}));
/** unique or primary key constraints on table "erp.PaymentHistory" */
var Erp_PaymentHistory_Constraint;
(function (Erp_PaymentHistory_Constraint) {
    /** unique or primary key constraint */
    Erp_PaymentHistory_Constraint["PaymentHistoryIdKey"] = "PaymentHistory_id_key";
    /** unique or primary key constraint */
    Erp_PaymentHistory_Constraint["PaymentHistoryPkey"] = "PaymentHistory_pkey";
})(Erp_PaymentHistory_Constraint = exports.Erp_PaymentHistory_Constraint || (exports.Erp_PaymentHistory_Constraint = {}));
/** select columns of table "erp.PaymentHistory" */
var Erp_PaymentHistory_Select_Column;
(function (Erp_PaymentHistory_Select_Column) {
    /** column name */
    Erp_PaymentHistory_Select_Column["Date"] = "Date";
    /** column name */
    Erp_PaymentHistory_Select_Column["Id"] = "ID";
    /** column name */
    Erp_PaymentHistory_Select_Column["OrderId"] = "OrderID";
    /** column name */
    Erp_PaymentHistory_Select_Column["PaidAmount"] = "PaidAmount";
})(Erp_PaymentHistory_Select_Column = exports.Erp_PaymentHistory_Select_Column || (exports.Erp_PaymentHistory_Select_Column = {}));
/** update columns of table "erp.PaymentHistory" */
var Erp_PaymentHistory_Update_Column;
(function (Erp_PaymentHistory_Update_Column) {
    /** column name */
    Erp_PaymentHistory_Update_Column["Date"] = "Date";
    /** column name */
    Erp_PaymentHistory_Update_Column["Id"] = "ID";
    /** column name */
    Erp_PaymentHistory_Update_Column["OrderId"] = "OrderID";
    /** column name */
    Erp_PaymentHistory_Update_Column["PaidAmount"] = "PaidAmount";
})(Erp_PaymentHistory_Update_Column = exports.Erp_PaymentHistory_Update_Column || (exports.Erp_PaymentHistory_Update_Column = {}));
/** unique or primary key constraints on table "erp.Tokens" */
var Erp_Tokens_Constraint;
(function (Erp_Tokens_Constraint) {
    /** unique or primary key constraint */
    Erp_Tokens_Constraint["TokrnsPkey"] = "Tokrns_pkey";
})(Erp_Tokens_Constraint = exports.Erp_Tokens_Constraint || (exports.Erp_Tokens_Constraint = {}));
/** select columns of table "erp.Tokens" */
var Erp_Tokens_Select_Column;
(function (Erp_Tokens_Select_Column) {
    /** column name */
    Erp_Tokens_Select_Column["Id"] = "ID";
    /** column name */
    Erp_Tokens_Select_Column["RefreshToken"] = "RefreshToken";
    /** column name */
    Erp_Tokens_Select_Column["UserId"] = "UserID";
})(Erp_Tokens_Select_Column = exports.Erp_Tokens_Select_Column || (exports.Erp_Tokens_Select_Column = {}));
/** update columns of table "erp.Tokens" */
var Erp_Tokens_Update_Column;
(function (Erp_Tokens_Update_Column) {
    /** column name */
    Erp_Tokens_Update_Column["Id"] = "ID";
    /** column name */
    Erp_Tokens_Update_Column["RefreshToken"] = "RefreshToken";
    /** column name */
    Erp_Tokens_Update_Column["UserId"] = "UserID";
})(Erp_Tokens_Update_Column = exports.Erp_Tokens_Update_Column || (exports.Erp_Tokens_Update_Column = {}));
/** unique or primary key constraints on table "erp.Users" */
var Erp_Users_Constraint;
(function (Erp_Users_Constraint) {
    /** unique or primary key constraint */
    Erp_Users_Constraint["UsersPkey"] = "Users_pkey";
})(Erp_Users_Constraint = exports.Erp_Users_Constraint || (exports.Erp_Users_Constraint = {}));
/** select columns of table "erp.Users" */
var Erp_Users_Select_Column;
(function (Erp_Users_Select_Column) {
    /** column name */
    Erp_Users_Select_Column["AccessLevelId"] = "AccessLevelID";
    /** column name */
    Erp_Users_Select_Column["Email"] = "Email";
    /** column name */
    Erp_Users_Select_Column["FirstName"] = "FirstName";
    /** column name */
    Erp_Users_Select_Column["LastName"] = "LastName";
    /** column name */
    Erp_Users_Select_Column["Password"] = "Password";
    /** column name */
    Erp_Users_Select_Column["UserId"] = "UserID";
})(Erp_Users_Select_Column = exports.Erp_Users_Select_Column || (exports.Erp_Users_Select_Column = {}));
/** update columns of table "erp.Users" */
var Erp_Users_Update_Column;
(function (Erp_Users_Update_Column) {
    /** column name */
    Erp_Users_Update_Column["AccessLevelId"] = "AccessLevelID";
    /** column name */
    Erp_Users_Update_Column["Email"] = "Email";
    /** column name */
    Erp_Users_Update_Column["FirstName"] = "FirstName";
    /** column name */
    Erp_Users_Update_Column["LastName"] = "LastName";
    /** column name */
    Erp_Users_Update_Column["Password"] = "Password";
    /** column name */
    Erp_Users_Update_Column["UserId"] = "UserID";
})(Erp_Users_Update_Column = exports.Erp_Users_Update_Column || (exports.Erp_Users_Update_Column = {}));
/** column ordering options */
var Order_By;
(function (Order_By) {
    /** in ascending order, nulls last */
    Order_By["Asc"] = "asc";
    /** in ascending order, nulls first */
    Order_By["AscNullsFirst"] = "asc_nulls_first";
    /** in ascending order, nulls last */
    Order_By["AscNullsLast"] = "asc_nulls_last";
    /** in descending order, nulls first */
    Order_By["Desc"] = "desc";
    /** in descending order, nulls first */
    Order_By["DescNullsFirst"] = "desc_nulls_first";
    /** in descending order, nulls last */
    Order_By["DescNullsLast"] = "desc_nulls_last";
})(Order_By = exports.Order_By || (exports.Order_By = {}));
exports.InsertDocsArrayMutationDocument = (0, graphql_tag_1.default) `
    mutation InsertDocsArrayMutation($objects: [erp_Docs_insert_input!]!) {
  insert_erp_Docs(objects: $objects) {
    returning {
      ID
      Key
    }
  }
}
    `;
exports.DeleteDocsMutationDocument = (0, graphql_tag_1.default) `
    mutation DeleteDocsMutation($Key: String!) {
  delete_erp_Docs(where: {Key: {_eq: $Key}}) {
    returning {
      Key
    }
  }
}
    `;
exports.AllOrdersPaymentsDataQueryDocument = (0, graphql_tag_1.default) `
    query AllOrdersPaymentsDataQuery {
  erp_Orders(where: {OrderStatusID: {_eq: 3}}, order_by: {OrderID: desc}) {
    OrderID
    PaidAmount
    TotalAmount
  }
}
    `;
exports.UnpaidOrdersQueryDocument = (0, graphql_tag_1.default) `
    query UnpaidOrdersQuery($unpaidIDs: [Int!], $OrderStatus: Int!) {
  erp_Orders(
    where: {OrderStatusID: {_eq: $OrderStatus}, OrderID: {_in: $unpaidIDs}}
  ) {
    OrderID
    Entity
    InvoiceNumber
    City
    OrderStatusID
    ShippingDate
    PaidAmount
    TotalAmount
    AwaitingDispatch
    ActualShippingDate
    CreatingDate
    ManagerID
    OrderItems {
      Quantity
      OrderItemID
      Name
    }
    User {
      FirstName
    }
  }
}
    `;
exports.AllTokensQueryDocument = (0, graphql_tag_1.default) `
    query AllTokensQuery {
  erp_Tokens {
    ID
    RefreshToken
    User {
      UserID
      FirstName
      LastName
      Email
      AccessLevelID
    }
  }
}
    `;
exports.InsertTokenMutationDocument = (0, graphql_tag_1.default) `
    mutation InsertTokenMutation($UserID: Int!, $refreshToken: String!) {
  insert_erp_Tokens(objects: {UserID: $UserID, RefreshToken: $refreshToken}) {
    returning {
      UserID
    }
  }
}
    `;
exports.DeleteTokenMutationDocument = (0, graphql_tag_1.default) `
    mutation DeleteTokenMutation($refreshToken: String!) {
  delete_erp_Tokens(where: {RefreshToken: {_eq: $refreshToken}}) {
    returning {
      UserID
    }
  }
}
    `;
exports.UpdateTokenMutationDocument = (0, graphql_tag_1.default) `
    mutation UpdateTokenMutation($tokenID: Int!, $refreshToken: String!) {
  update_erp_Tokens_by_pk(
    pk_columns: {ID: $tokenID}
    _set: {RefreshToken: $refreshToken}
  ) {
    ID
    UserID
  }
}
    `;
exports.AllUsersQueryDocument = (0, graphql_tag_1.default) `
    query AllUsersQuery {
  erp_Users {
    UserID
    FirstName
    LastName
    Email
    Password
    AccessLevelID
  }
}
    `;
function getSdk(requester) {
    return {
        InsertDocsArrayMutation(variables, options) {
            return requester(exports.InsertDocsArrayMutationDocument, variables, options);
        },
        DeleteDocsMutation(variables, options) {
            return requester(exports.DeleteDocsMutationDocument, variables, options);
        },
        AllOrdersPaymentsDataQuery(variables, options) {
            return requester(exports.AllOrdersPaymentsDataQueryDocument, variables, options);
        },
        UnpaidOrdersQuery(variables, options) {
            return requester(exports.UnpaidOrdersQueryDocument, variables, options);
        },
        AllTokensQuery(variables, options) {
            return requester(exports.AllTokensQueryDocument, variables, options);
        },
        InsertTokenMutation(variables, options) {
            return requester(exports.InsertTokenMutationDocument, variables, options);
        },
        DeleteTokenMutation(variables, options) {
            return requester(exports.DeleteTokenMutationDocument, variables, options);
        },
        UpdateTokenMutation(variables, options) {
            return requester(exports.UpdateTokenMutationDocument, variables, options);
        },
        AllUsersQuery(variables, options) {
            return requester(exports.AllUsersQueryDocument, variables, options);
        }
    };
}
exports.getSdk = getSdk;
//# sourceMappingURL=schema-typedefs.js.map