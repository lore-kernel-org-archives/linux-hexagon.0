From: "Brian Cain" <bcain@codeaurora.org>
Subject: RE: [PATCH 0/6] Kill setup_irq()
Date: Fri, 27 Mar 2020 21:48:38 -0500
Message-ID: <059b01d604ab$637355b0$2a5a0110$@codeaurora.org>
References: <20200321174303.GA7930@afzalpc>
 <cover.1585320721.git.afzal.mohd.ma@gmail.com>
Reply-To: bcain@codeaurora.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:
	Subject:In-Reply-To:References:To:From:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Z+uXNWOjzlg3ffXJIcoE1eOsW/6hxlFtVBLEwuoaaxY=; b=SliCrckbOAG1Wu
	XoyfLTGv8Uaz5Fde7CEABjqK8ZmyzEHS0amCN5xoV4nTDPJs8wpuy8nTGzrIYeaOA5Bh1RjkwOzDO
	UKuJ8Ul+kv/O52PDj7EW5Inr9qq91wcdhSCgkAkHjzN1OoVYfuy3o75FoWGFVbsu2mLiXNDtLmIzU
	ApsVAXhx0tweki+9J3eBd6kyizHNM2pJDt3p9K5UdTAcMthZKPXYJp17SibiaHCuwCzhvA+tuFhdP
	4Tk+smfza9N+PMka3m8tzWLykj/vRK7f6ds7Kd0O4+Dx6QDjdvq3jy1Z15mhwBDWG1uKHaWD9bcun
	NxWN8ZzWrFigOn5KWA3g==;
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1585363727; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: Date: Subject: In-Reply-To: References: Cc:
 To: From: Reply-To: Sender;
 bh=+WpPnB0uFYRHxbJdTSXbZ3CsA3rPO9kHVEIdO35S7As=;
 b=ESwcKj3vwkCnso6wo1WRq/Q5sn1hqVCiEleSCsgR6loBPSShfWgKKSrGNTCPrNih0XvzT7BA
 I7mG5VlpkRKFzsRQO1dJlvwS1bTaswd4OPhtQ7A+0uhSI8KNTjEi/EgoqsvkiUc/1moJaZTR
 FZbRhxOfBVkZ9lMNSJHOdnDVacg=
In-Reply-To: <cover.1585320721.git.afzal.mohd.ma@gmail.com>
Content-Language: en-us
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: 'afzal mohammed' <afzal.mohd.ma@gmail.com>, 'Thomas Gleixner' <tglx@linutronix.de>
Cc: linux-s390@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-ia64@vger.kernel.org, linux-c6x-dev@linux-c6x.org, linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, linux-hexagon@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-alpha@vger.kernel.org, linux-omap@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org

> -----Original Message-----
> From: linux-hexagon-owner@vger.kernel.org <linux-hexagon-
> owner@vger.kernel.org> On Behalf Of afzal mohammed
> Sent: Friday, March 27, 2020 11:08 AM
> To: Thomas Gleixner <tglx@linutronix.de>
> Cc: linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> linux-samsung-soc@vger.kernel.org; x86@kernel.org; linux-
> sh@vger.kernel.org; linux-s390@vger.kernel.org; linuxppc-
> dev@lists.ozlabs.org; linux-parisc@vger.kernel.org; linux-
> mips@vger.kernel.org; linux-m68k@lists.linux-m68k.org; linux-
> ia64@vger.kernel.org; linux-hexagon@vger.kernel.org; linux-c6x-dev@linux-
> c6x.org; linux-omap@vger.kernel.org; linux-alpha@vger.kernel.org
> Subject: [PATCH 0/6] Kill setup_irq()
...
> Note 1: sh toolchain is available, but that will not make the  relevant
changes
> compile as it has dependency of 64bit arch toolchain,  did try a Kconfig
hack
> to make it compile w/ 32bit sh toolchain, but it  failed due to other
reasons
> (unknown operands), so gave up on that.
> Note 2: hexagon final image creation fails even w/o my patch, but it  has
> been ensured that w/ my changes relevant object files are getting  built
w/o
> warnings.

Afzal,

	What's the nature of the failure in "Note 2"?

-Brian
