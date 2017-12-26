<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ara.aspx.cs" Inherits="filmProje.ara" %>
<%@ Register Assembly="CollectionPager" Namespace="SiteUtils" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="headContent" runat="server">
    <meta name="robots" content="noindex,follow"/>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
    <asp:Repeater ID="filmler" runat="server">
        <ItemTemplate>
            <div class="col s6 m4 l4">
                <div class="filmafis">
                    <a href="film/<%#Eval("URL") %>"><img src="images/upload/<%#Eval("Poster") %>?width=216&height=320&mode=max&quality=60" class="hoverable width100" alt="<%#Eval("Baslik") %>" title="<%#Eval("Baslik") %>" title="<%#Eval("Baslik") %>"></a>
                    <div class="filmaltbilgi">
                        <div class="filmimdb">
                            IMDB Puanı: <%#Eval("IMDB") %> /10
                        </div>
                        <div class="filmbaslik">
                            <%#Eval("Baslik") %>
                        </div>
                    </div>
                </div>
            </div>
        </ItemTemplate>
    </asp:Repeater>
</div>
<div class="sayfalamay">
    <cc1:CollectionPager ID="CollectionPager1" runat="server" ShowPageNumbers="True" LabelText="" ControlCssClass="sayfalamayeni" PageSize="15" NextText="Sonraki" LastText="Son" BackText="Önceki" FirstText="İlk" ResultsFormat="" BackNextDisplay="HyperLinks" BackNextLocation="Split" BackNextStyle="margin:0px 15px" MaxPages="999999" PageNumbersDisplay="Numbers" ShowFirstLast="False"></cc1:CollectionPager>
    <div class="clear"></div>
</div>
</asp:Content>
