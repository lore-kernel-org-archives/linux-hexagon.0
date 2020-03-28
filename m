From: afzal mohammed <afzal.mohd.ma@gmail.com>
Subject: Re: [PATCH 0/6] Kill setup_irq()
Date: Sat, 28 Mar 2020 13:02:53 +0530
Message-ID: <20200328073253.GA5250@afzalpc>
References: <20200321174303.GA7930@afzalpc>
 <cover.1585320721.git.afzal.mohd.ma@gmail.com>
 <059b01d604ab$637355b0$2a5a0110$@codeaurora.org>
Mime-Version: 1.0
Return-path: <linux-m68k-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+lojOXOS3R1T9zdX8YSaUVNPC+Uk4217Q9UeUwGqUmA=;
        b=jl9qdfm3jYBUJpt5JTOg0fpX+frk2U8CDB7NHla700eqbFzeaU5ddRrnkF9ulMws0I
         c9g6XZd+U1YMZF9/3LdLKd5v8wOHCvTpOK+41v0dC3rQjbl2zkCOwiKzOqyresW/3Mhq
         BcOd0bkAnUi+Zs7kVOtOgih+P95QQehDeut+bVNmK8w/pAqzhJa2/sY/cLipp5Rtomn+
         y0jJ0Kfcg23Own5fnZnDcgXrP0oJy8MDqN1sdD4UE300VgF+beh9dCTKovy8+8QPgJF7
         tM2KC+Uqrh6IJRCMsJf7pzvSFnZ37F703JjyJuB4ywUQrA0N8cjQpQZ/4AufrBOA8und
         kRiA==
Content-Disposition: inline
In-Reply-To: <059b01d604ab$637355b0$2a5a0110$@codeaurora.org>
Sender: linux-m68k-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Brian Cain <bcain@codeaurora.org>
Cc: 'Thomas Gleixner' <tglx@linutronix.de>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, x86@kernel.org, linux-sh@vger.kernel.org, linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-parisc@vger.kernel.org, linux-mips@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-ia64@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-c6x-dev@linux-c6x.org, linux-omap@vger.kernel.org, linux-alpha@vger.kernel.org

Hi Brian,

On Fri, Mar 27, 2020 at 09:48:38PM -0500, Brian Cain wrote:

> > Note 2: hexagon final image creation fails even w/o my patch

> 	What's the nature of the failure in "Note 2"?

drivers/base/firmware_loader/main.o: In function `fw_is_builtin_firmware':
/devel/src/kernel6/drivers/base/firmware_loader/main.c:132:(.text+0xc8): relocation truncated to fit: R_HEX_16_X against symbol `__start_builtin_fw' defined in .modinfo section in .tmp_vmlinux1
Makefile:1077: recipe for target 'vmlinux' failed
make: *** [vmlinux] Error 1

[ i had deleted the toolchain earlier, since you asked, download again &
checked ]

Regards
afzal
