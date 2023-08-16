From: Jesse Taube <mr.bossman075@gmail.com>
Subject: Re: [PATCH] treewide: drop CONFIG_EMBEDDED
Date: Wed, 16 Aug 2023 18:45:12 -0400
Message-ID: <38e1a01b-1e8b-7c66-bafc-fc5861f08da9@gmail.com>
Reply-To: 20230816055010.31534-1-rdunlap@infradead.org
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-mips-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692225914; x=1692830714;
        h=content-transfer-encoding:subject:from:reply-to:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MGoBkEwlCnbJad+CecbjRY+VjiJK8E7bojDgpjg7FvU=;
        b=J+2GZw9sDgAuPCvyYPqSvvzp1lVg6wE6qeMOlcYMGPuThPNLCGYiiW2dwFVq91l/vl
         NT/yeq5xZ4Ufc7IZxR6ugOwOZQfg5nMbUshmMxhNTewriji8eUuaNn0c360FPsW5tkH4
         6cS/vKC7K0l0lZLKGVqDi2VTUmRXgo+WSJJ9fOFjLJU7uhgHYQzddKm06zxNwf3BXFjN
         SCDUE56G1UeYAPYGs2dGSOsKeDDFiUZRdgQwqGIeL2NpPJhlcnrVVGytRXUYD0OF20a4
         87SE8XWZHMx/EGlk2yISP6pygxQx+aQ11VINZVZvJIAIyOIfvz+sxSaS9uqbom35csu9
         8sYQ==
Content-Language: en-US
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, "Jason A . Donenfeld" <Jason@zx2c4.com>, wireguard@lists.zx2c4.com, linux-arch@vger.kernel.org, linux-snps-arc@lists.infradead.org, Vineet Gupta <vgupta@kernel.org>, Brian Cain <bcain@quicinc.com>, linux-hexagon@vger.kernel.org, Greg Ungerer <gerg@linux-m68k.org>, linux-m68k@lists.linux-m68k.org, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, linux-openrisc@vger.kernel.org, linux-mips@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>

Hi, Randy

 > diff -- a/init/Kconfig b/init/Kconfig
 > --- a/init/Kconfig
 > +++ b/init/Kconfig
 > @@ -1790,14 +1790,6 @@ config DEBUG_RSEQ
 >
 >  	  If unsure, say N.
 >
 > -config EMBEDDED
 > -	bool "Embedded system"
 > -	select EXPERT
 > -	help
 > -	  This option should be enabled if compiling the kernel for
 > -	  an embedded system so certain expert options are available
 > -	  for configuration.

Wouldn't removing this break many out of tree configs?
Should there be a warning here to update change it instead of removal?

Thanks,
Jesse Taube
