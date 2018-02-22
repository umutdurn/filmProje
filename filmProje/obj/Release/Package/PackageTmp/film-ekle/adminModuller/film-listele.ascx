<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="film-listele.ascx.cs" Inherits="filmProje.film_ekle.adminModuller.yorumlar" %>
<%@ Register Assembly="CollectionPager" Namespace="SiteUtils" TagPrefix="cc1" %>
<div class="g_6 contents_header">
 	<h3 class="i_16_dashboard tab_label">Filmleri Listele</h3>
 	<div><span class="label">Film düzenle sil ve ekle.</span></div>
 </div>
 <div class="g_6 contents_options">
 	<div class="simple_buttons">
 		<div class="bwIcon i_16_help">Help</div>
 	</div>
 	<div class="simple_buttons">
 		<div class="bwIcon i_16_settings">Settings</div>
 		<div class="buttons_arrow">
 			<!-- Drop Menu -->
 			<ul class="drop_menu menu_with_icons right_direction">
              <li>
  	            <a class="i_16_add" href="#" title="New Flie">
  		            <span class="label">New File</span>
  	            </a>  	
              </li>
              <li>
  	            <a class="i_16_progress" href="#" title="2 Files Left">
  		            <span class="label">Files Left</span>
  		            <span class="small_count">2</span>
  	            </a>
              </li>
              <li>
  	            <a class="i_16_files" href="#" title="Browse Files">
  		            <span class="label">Browse Files</span>
  	            </a>
              </li>
 			</ul>
 		</div>
 	</div>
 </div>
<div class="g_12 separator"><span></span></div>
<div class="g_12">
    <div class="widget_header">
	    <h4 class="widget_header_title wwIcon i_16_forms">Filmler</h4>
    </div>
    <div class="widget_contents noPadding">
	    <div class="line_grid">
            <asp:Repeater ID="rptFilmler" runat="server">
                <HeaderTemplate>
                    <table class="listTable">
                        <tr>
                            <td><strong>Film Adı</strong></td>
                            <td class="center"><strong>Gelecek</strong></td>
                            <td class="center"><strong>İzlenme</strong></td>
                            <td class="center"><strong>Yapım Yılı</strong></td>
                            <td class="center"><strong>IMDB</strong></td>
                            <td class="center"><strong>Seçim</strong></td>
                        </tr>
                </HeaderTemplate>
                <ItemTemplate>
                        <asp:HiddenField ID="hddID" Value='<%#Eval("ID") %>' runat="server" />
                        <tr>
                            <td><%#Eval("Baslik") %>
                                <div>
                                    <ul>
                                        <li><a href="http://<%=Request.Url.Host.ToLower() %>/film/<%#Eval("URL") %>" target="_blank">Görüntüle</a></li>
                                        <li><a href="yonetim?pnl=filmekle&duzenle=<%#Eval("ID") %>">Düzenle</a></li>
                                        <li><a href="#">Sil</a></li>
                                    </ul>
                                </div>
                            </td>
                            <td class="center"><%#Eval("Gelecek").ToString() == "1" ? "Fragman" : "Film" %></td>
                            <td class="center"><%#Eval("Inceleme") %></td>
                            <td class="center"><%#Eval("YapimYili") %></td>
                            <td class="center"><%#Eval("IMDB") %></td>
                            <td class="center">
                                <asp:CheckBox ID="chckSlider" runat="server" AutoPostBack="True" OnCheckedChanged="CheckBox1_CheckedChanged" Checked='<%#Eval("Slider").ToString() == "1" ? true : false %>' />
                                </td>
                        </tr>
                </ItemTemplate>
                <FooterTemplate>
                    </table>
                </FooterTemplate>
            </asp:Repeater>
            <div class="sayfalamay">
                <cc1:CollectionPager ID="CollectionPager1" runat="server" ShowPageNumbers="True" LabelText="" ControlCssClass="sayfalamayeni" PageSize="30" NextText="Sonraki" LastText="Son" BackText="Önceki" FirstText="İlk" ResultsFormat="" BackNextDisplay="HyperLinks" BackNextLocation="Split" BackNextStyle="margin:0px 15px" MaxPages="999999" PageNumbersDisplay="Numbers" ShowFirstLast="False"></cc1:CollectionPager>
                <div class="clear"></div>
            </div>
	    </div>
    </div>
</div>
