<%@ Page Title="" Language="C#" MasterPageFile="~/film-ekle/yonetim.Master" AutoEventWireup="true" CodeBehind="yonetim.aspx.cs" Inherits="filmProje.film_ekle.yonetim1" %>

<%@ Register Src="~/film-ekle/adminModuller/film-ekle.ascx" TagPrefix="uc1" TagName="filmekle" %>
<%@ Register Src="~/film-ekle/adminModuller/kategoriler.ascx" TagPrefix="uc1" TagName="kategoriler" %>
<%@ Register Src="~/film-ekle/adminModuller/siteharitasi.ascx" TagPrefix="uc1" TagName="siteharitasi" %>
<%@ Register Src="~/film-ekle/adminModuller/film-listele.ascx" TagPrefix="uc1" TagName="filmlistele" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="../Scripts/ckeditor/adapters/jquery.js"></script>
    <script src="../Scripts/ckeditor/ckeditor.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Panel ID="AnaPanel" runat="server">
        <asp:Panel ID="pnlfilmlistele" runat="server" Visible="false">
            <uc1:filmlistele runat="server" id="filmlistele" />
        </asp:Panel>
        <asp:Panel ID="pnlfilmekle" runat="server" Visible="false">
            <uc1:filmekle runat="server" id="filmekle" />
        </asp:Panel>
        <asp:Panel ID="pnlkategoriekle" runat="server" Visible="false">
            <uc1:kategoriler runat="server" id="kategoriler" />
        </asp:Panel>
        <asp:Panel ID="pnlxmlharita" Visible="false" runat="server">
            <uc1:siteharitasi runat="server" id="siteharitasi" />
        </asp:Panel>
        <asp:Panel ID="pnlyorumlar" Visible="false" runat="server">
            
        </asp:Panel>
    </asp:Panel>
</asp:Content>
