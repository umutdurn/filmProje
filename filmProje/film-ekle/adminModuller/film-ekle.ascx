<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="film-ekle.ascx.cs" Inherits="filmProje.film_ekle.adminModuller.film_ekle" %>
<div class="g_6 contents_header">
 	<h3 class="i_16_dashboard tab_label">Film Ekle</h3>
 	<div><span class="label">Web sitesine yeni filmleri ekleyin.</span></div>
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
	    <h4 class="widget_header_title wwIcon i_16_forms">Film Bilgileri</h4>
    </div>
    <div class="widget_contents noPadding">
	    <div class="line_grid">
		    <div class="g_3"><span class="label">Film Başlığı</span></div>
		    <div class="g_9">
                <asp:TextBox ID="txtFilmBasligi" CssClass="simple_field" runat="server"></asp:TextBox>
		    </div>
	    </div>
        <div class="line_grid">
		    <div class="g_3"><span class="label">Film R.URL</span></div>
		    <div class="g_9">
                <asp:TextBox ID="txtFilmURl" CssClass="simple_field" runat="server"></asp:TextBox>
		    </div>
	    </div>
        <div class="line_grid">
		    <div class="g_3"><span class="label">Meta Description</span></div>
		    <div class="g_9">
                <asp:TextBox ID="txtMetaDesc" CssClass="simple_field" runat="server" TextMode="MultiLine" Height="70"></asp:TextBox>
		    </div>
	    </div>
        <div class="line_grid">
		    <div class="g_3"><span class="label">Yönetmenler</span></div>
		    <div class="g_9">
                <asp:UpdatePanel ID="updateYonetmenler" runat="server">
                    <ContentTemplate>
                        <asp:Panel ID="pnlYonetmenlerDef" DefaultButton="btnYonetmenKayit" runat="server">
                            <asp:TextBox ID="txtYonetmenler" CssClass="simple_field" runat="server" Width="200"></asp:TextBox><asp:Button ID="btnYonetmenKayit" CssClass="submitIt simple_buttons" runat="server" Text="Kaydet" OnClick="btnYonetmenKayit_Click" />
                            <div class="yonetmenler">
                                <asp:Repeater ID="rptYonetmenler" runat="server" OnItemCommand="rptYonetmenler_ItemCommand">
                                    <ItemTemplate>
                                        <%#Eval("Yonetmen") %> <asp:ImageButton ID="imgYonetmenSil" runat="server" ImageUrl="~/images/sil.png" Width="12" CommandName="sil" CommandArgument='<%#Eval("ID") %>' />
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>
                        </asp:Panel>
                    </ContentTemplate>
                </asp:UpdatePanel>
		    </div>
	    </div>
        <div class="line_grid">
		    <div class="g_3"><span class="label">Oyuncular</span></div>
		    <div class="g_9">
                <asp:UpdatePanel ID="updateOyuncular" runat="server">
                    <ContentTemplate>
                        <asp:Panel ID="pnlOyuncularDef" DefaultButton="btnOyuncuKayit" runat="server">
                            <asp:TextBox ID="txtOyuncular" CssClass="simple_field" runat="server" Width="200"></asp:TextBox><asp:Button ID="btnOyuncuKayit" runat="server" CssClass="submitIt simple_buttons" Text="Kaydet" OnClick="btnOyuncuKayit_Click" />
                            <div class="oyuncular">
                                <asp:Repeater ID="rptOyuncular" runat="server" OnItemCommand="rptOyuncular_ItemCommand">
                                    <ItemTemplate>
                                        <%#Eval("Oyuncu") %> <asp:ImageButton ID="imgOyuncuSil" runat="server" ImageUrl="~/images/sil.png" Width="12" CommandName="sil" CommandArgument='<%#Eval("ID") %>' />
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>
                        </asp:Panel>
                    </ContentTemplate>
                </asp:UpdatePanel>
		    </div>
	    </div>
        <div class="line_grid">
		    <div class="g_6">
                <asp:TextBox ID="txtOrjinalAdi" CssClass="simple_field" placeholder="Orjinal Adı" runat="server"></asp:TextBox>
		    </div>
            <div class="g_6">
                <asp:TextBox ID="txtYapimYili" CssClass="simple_field" placeholder="Yapım Yılı" runat="server"></asp:TextBox>
		    </div>
	    </div>
        <div class="line_grid">
		    <div class="g_6">
                <div class="kategoriKaydir">
                    <asp:SqlDataSource ID="chckKategoriler_db" runat="server" ConnectionString="<%$ ConnectionStrings:constr %>" SelectCommand="SELECT * FROM [film_Kategoriler]"></asp:SqlDataSource>
                    <asp:CheckBoxList ID="chckKategoriler" CssClass="simple_form" runat="server" RepeatLayout="UnorderedList" DataSourceID="chckKategoriler_db" DataTextField="KategoriAdi" DataValueField="ID">
                    </asp:CheckBoxList>
                </div>
		    </div>
            <div class="g_6">
                <div class="g_3"><span class="label">Filmin Ülkesi</span></div>
		        <div class="g_9">
                    <asp:SqlDataSource ID="dropUlkeler_db" runat="server" ConnectionString="<%$ ConnectionStrings:constr %>" SelectCommand="SELECT * FROM [film_Ulkeler]"></asp:SqlDataSource>
                    <asp:DropDownList ID="dropUlkeler" CssClass="simple_form" runat="server" DataSourceID="dropUlkeler_db" DataTextField="UlkeAdi" DataValueField="UlkeURL">
                        <asp:ListItem>Deneme</asp:ListItem>
                    </asp:DropDownList>
		        </div>
                <div class="g_3"><span class="label">Filmin Süresi</span></div>
		        <div class="g_9">
                    <asp:TextBox ID="txtFilmSuresi" CssClass="simple_field" runat="server"></asp:TextBox>
		        </div>
                <div class="g_3"><span class="label">Filmin IMDB</span></div>
		        <div class="g_9">
                    <asp:TextBox ID="txtIMDB" CssClass="simple_field" runat="server"></asp:TextBox>
		        </div>
                <div class="g_3"><span class="label">Posteri</span></div>
		        <div class="g_9">
                    <asp:FileUpload ID="filePoster" runat="server" />
		        </div>
		    </div>
	    </div>
        <div class="line_grid">
            <asp:TextBox ID="txtEditor" TextMode="MultiLine" ValidateRequestMode="Disabled" runat="server"></asp:TextBox>
            <script type="text/javascript">
                //CKFinderScripts
                CKEDITOR.replace('<%=txtEditor.ClientID%>',
                {
                    filebrowserBrowseUrl: '../ckfinder/ckfinder.html',
                    filebrowserImageBrowseUrl: '../ckfinder/ckfinder.html?type=Images',
                    filebrowserUploadUrl: '../ckfinder/connector?command=QuickUpload&type=Files',
                    filebrowserImageUploadUrl: '../ckfinder/connector?command=QuickUpload&type=Images'
                });
            </script>
        </div>
        <div class="line_grid">
            <asp:UpdatePanel ID="updatePart" runat="server">
                <ContentTemplate>
                    <div class="g_3"><span class="label">Part Adı</span></div>
                    <div class="g_9">
                        <asp:TextBox ID="txtPartAdi" CssClass="simple_field" runat="server"></asp:TextBox>
                        <span class="label">Not: İlk partı "Fragman" ismi ile girmeniz önerilir.</span>
                    </div>
                    <div class="g_3"><span class="label">İframe</span></div>
                    <div class="g_9">
                        <asp:TextBox ID="txtIframe" ValidateRequestMode="Disabled" Height="70" TextMode="MultiLine" CssClass="simple_field" runat="server"></asp:TextBox>
                    </div>
                    <div class="g_3"><span class="label">Kalitesi</span></div>
                    <div class="g_9">
                        <asp:DropDownList ID="dropKalite" runat="server">
                            <asp:ListItem>480p</asp:ListItem>
                            <asp:ListItem>720p</asp:ListItem>
                            <asp:ListItem>1080p</asp:ListItem>
                            <asp:ListItem>2K</asp:ListItem>
                            <asp:ListItem>4K</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="g_3"><span class="label">Part Dili</span></div>
                    <div class="g_9">
                        <asp:DropDownList ID="dropDil" runat="server">
                            <asp:ListItem>Türkçe Dublaj</asp:ListItem>
                            <asp:ListItem>Altyazılı</asp:ListItem>
                            <asp:ListItem>Orjinal Dil</asp:ListItem>
                            <asp:ListItem>Fragman</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="clear"></div>
                    <div class="partAyrac"></div>
                    <asp:Button ID="btnPartEkle" runat="server" Text="Part Ekle" OnClick="btnPartEkle_Click" CssClass="submitIt simple_buttons" />
                    <div class="partUyari">Not: Part silmek istediğiniz zaman, "Sil" butonuna tıklayınız. Bu işlem anında gerçekleşir(<strong>Filmi kaydetmeye gerek yoktur</strong>) ve geri dönüşü yoktur.</div>
                    <div class="partAyrac"></div>
                    <div class="clear"></div>
                    <asp:Repeater ID="rptPartlar" runat="server" OnItemCommand="rptPartlar_ItemCommand">
                        <ItemTemplate>
                                <div class="g_3"><span class="label">Part Adı</span></div>
		                        <div class="g_9">
                                    <%#Eval("PartAdi") %>
		                        </div>
                                <div class="g_3"><span class="label">İframe</span></div>
		                        <div class="g_9">
                                    <%#Eval("Iframe") %>
		                        </div>
                                <div class="g_3"><span class="label">Kalitesi</span></div>
		                        <div class="g_9">
                                    <%#Eval("Kalitesi") %>
		                        </div>
                                <div class="g_3"><span class="label">Part Dili</span></div>
		                        <div class="g_9">
                                    <%#Eval("Dil") %>
		                        </div>
                                <div class="clear"></div>
                                <div class="line_grid">
                                    <asp:Button ID="btnPartSil" runat="server" Text="Sil" CssClass="submitIt simple_buttons" CommandName="sil" CommandArgument='<%#Eval("ID") %>' />
                                </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
        <div class="line_grid">
            <asp:Button ID="btnKaydet" runat="server" Text="Filmi Kayıt Et" CssClass="submitIt simple_buttons" OnClick="btnKaydet_Click" />
        </div>
    </div>
</div>