From: "Arnd Bergmann" <arnd@arndb.de>
Subject: Re: [PATCH] treewide: drop CONFIG_EMBEDDED
Date: Wed, 16 Aug 2023 15:11:35 +0200
Message-ID: <0681968f-743d-4b55-bb1e-dbd665ea8783@app.fastmail.com>
References: <20230816055010.31534-1-rdunlap@infradead.org>
Mime-Version: 1.0
Return-path: <wireguard-bounces@lists.zx2c4.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
 :cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:sender
 :subject:subject:to:to; s=fm3; t=1692191534; x=1692277934; bh=ZR
 T106v0hiqgMDmrCmS6eySFqP6+naQFmpKPfl1LC4A=; b=vnOGsLEBWf6iRqdcGe
 aKN5BWG0fJGAVU6JVIXw2r5trEbi4U8HGAkyD0+6xPYUebCuLdj/BgvHcLXQ3VWz
 DM86GEBHF5q/32OBTSQ1jAmNdTLIKRxKeTpDjT17bQgiqwms96qRRheqtFVNxibZ
 hwb68kNFhtdjc0mMi067Ltuik7Sz8Ub0DzdHrBDczZvPLkmNw72p43WeSwcA6Uhd
 jlAAKWZ6Al07ksUMdho4dSrDxHjxQNY7apoz3xCtR88uxRhkG9xkFDGscnnRTo5l
 WiGl5SfVo9TNOcr+c7G2H0chHBT3ePUGo7ZEdPXRmkEqRq9XFAWEkvI8BxCAowqC
 qylw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; t=1692191534; x=1692277934; bh=ZRT106v0hiqgM
 DmrCmS6eySFqP6+naQFmpKPfl1LC4A=; b=J253saPLCyaYpeIDlShp7YvjJgenV
 Ht1wUlTeHrAp+sMBGixfNZyUOs+v29RrlwC/Ff32lR6rR8Ptf/e2eCzpS7zg4WOK
 JYImEvkjD5EcWi13FT1qPlKSW+lxLDrtzkAe+SPR9zQ5OXHVI5o5ZavoAdaJjrvF
 mYs/WGtCNnfkuosVJ63bXDJlTIEuUUTya6gHAHWER0NlUHQA4H1Y/6SUWW5k7VGX
 CgelTXP6IMV844RF/eUDrOP+e8y9sL3KhWck/HUsbwg8VPAFec37UpcjQLZf4mWh
 uldSfe9YCl3AXDW8zsfBvdpTuUvrJa25ROBLezhFUT/OIhB48LEBQcZnA==
In-Reply-To: <20230816055010.31534-1-rdunlap@infradead.org>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <https://lists.zx2c4.com/mailman/options/wireguard>,
 <mailto:wireguard-request@lists.zx2c4.com?subject=unsubscribe>
List-Archive: <http://lists.zx2c4.com/pipermail/wireguard/>
List-Post: <mailto:wireguard@lists.zx2c4.com>
List-Help: <mailto:wireguard-request@lists.zx2c4.com?subject=help>
List-Subscribe: <https://lists.zx2c4.com/mailman/listinfo/wireguard>,
 <mailto:wireguard-request@lists.zx2c4.com?subject=subscribe>
Errors-To: wireguard-bounces@lists.zx2c4.com
Sender: "WireGuard" <wireguard-bounces@lists.zx2c4.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, "Jason A . Donenfeld" <Jason@zx2c4.com>, wireguard@lists.zx2c4.com, Linux-Arch <linux-arch@vger.kernel.org>, linux-snps-arc@lists.infradead.org, Vineet Gupta <vgupta@kernel.org>, Brian Cain <bcain@quicinc.com>, linux-hexagon@vger.kernel.org, Greg Ungerer <gerg@linux-m68k.org>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, "linux-openrisc@vger.kernel.org" <linux-openrisc@vger.kernel.org>, linux-mips@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe

On Wed, Aug 16, 2023, at 07:50, Randy Dunlap wrote:
> There is only one Kconfig user of CONFIG_EMBEDDED and it can be
> switched to EXPERT or "if !ARCH_MULTIPLATFORM" (suggested by Arnd).
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Jason A. Donenfeld <Jason@zx2c4.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
