From: "Russell King (Oracle)" <linux@armlinux.org.uk>
Subject: Re: [PATCH 16/21] ARM: dma-mapping: bring back dmac_{clean,inv}_range
Date: Mon, 27 Mar 2023 14:10:32 +0100
Message-ID: <ZCGVyB+Sdve78LrK@shell.armlinux.org.uk>
References: <20230327121317.4081816-1-arnd@kernel.org>
 <20230327121317.4081816-17-arnd@kernel.org>
Mime-Version: 1.0
Return-path: <linux-mips-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=FP/g5MMoh+bWH6/vaV4x7gdcx8r1AfO8OwzqUj0gats=; b=BYOMa7b7myCi6QMrt+S21c5RGt
        YZDhEXdlYS9/d40xW81RY3VSFHod0WMESd9MiyZKORnxnEZFeVJJs7K9EQpCCJNgACyCDiWwXsPpF
        2ncxKuwaEj+3S6ea0k5rIgw856TBVM7SFtMKupTw4OZBsMh//aO6uH7zbUx8Sbaq5V1oENeXmR4Vh
        loGRRUxL9sZTfR/yJHmBKGHA4OwzrrWY32nZcUlyLJv+oeCwO/EaBTazPTgD3adb6YTVyS8/5GbNt
        xTGhL00gRXzdrhq16LpLYea53LMoH2KCDQ7kcOIb5YUjAGGqvLHrMH1gd6RuV30JD6ZwdzzKEiLDp
Content-Disposition: inline
In-Reply-To: <20230327121317.4081816-17-arnd@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@quicinc.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Dinh Nguyen <dinguyen@kernel.org>, Stafford Horne <shorne@gmail.com>, Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <christophe.leroy@csgroup.eu>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Rich Felker <dalias@libc.org>, John

On Mon, Mar 27, 2023 at 02:13:12PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> These were remove ages ago in commit 702b94bff3c5 ("ARM: dma-mapping:
> remove dmac_clean_range and dmac_inv_range") in an effort to sanitize
> the dma-mapping API.

Really no, please no. Let's not go back to this, let's keep the
buffer ownership model that came at around that time.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
