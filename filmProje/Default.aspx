<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="filmProje._Default" %>
<%@ Register Assembly="CollectionPager" Namespace="SiteUtils" TagPrefix="cc1" %>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
<div class="row">
    <asp:Repeater ID="filmler" runat="server">
        <ItemTemplate>
            <div class="col s6 m4 l4">
                <div class="filmafis">
                    <a href="film/<%#Eval("URL") %>"><img src="images/upload/<%#Eval("Poster") %>" class="hoverable width100" alt="<%#Eval("Baslik") %>" title="<%#Eval("Baslik") %>" title="<%#Eval("Baslik") %>"></a>
                    <div class="filmaltbilgi">
                        <div class="filmimdb">
                            IMDb Puanı: <%#Eval("IMDB") %> /10
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
    <cc1:CollectionPager ID="CollectionPager1" runat="server" ShowPageNumbers="True" LabelText="" ControlCssClass="sayfalamayeni" PageSize="12" NextText="Sonraki" LastText="Son" BackText="Önceki" FirstText="İlk" ResultsFormat="" BackNextDisplay="HyperLinks" BackNextLocation="Split" BackNextStyle="margin:0px 15px" MaxPages="999999" PageNumbersDisplay="Numbers" ShowFirstLast="False"></cc1:CollectionPager>
    <div class="clear"></div>
</div>
</asp:Content>
