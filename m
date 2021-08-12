From: "Russell King (Oracle)" <linux@armlinux.org.uk>
Subject: Re: [PATCH -next] trap: Cleanup trap_init()
Date: Thu, 12 Aug 2021 13:41:41 +0100
Message-ID: <20210812124141.GY22278@shell.armlinux.org.uk>
References: <20210812123602.76356-1-wangkefeng.wang@huawei.com>
Mime-Version: 1.0
Return-path: <linux-parisc-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xC/TZD3ZIXMs1cMiTUUAC6x6j656qE6poOPOz0bbgp4=; b=BIIYYrXJ3Ew+Z1Zm5diqSi/De
        z9wV3zfjmSLaZp7CLzV+GZVzZq7gHn4aYTS+otHAxBF57P3sG+08JwSPBCdCFZWJ+W/a7Uq2nG6dR
        Ha2YFBjZclMZJYIiXKlQ1gLB8ZCdS8B9uEW3WbpCbGK0H/IdQLdkF8gVEx0au/w4sNkwsnJxOlaJN
        3F0T/x1fYsMd3E4PDbHDx53iR0C3e0RKKbXsP6YegqA39Ad4vclW52rD2Iu/mHbjVJqRpkjlhVtux
        jBq7gk1O4Rj655JZe+cFH0MNa946zYFR94AnA24dA5R1E6RDmcUCiw2sBMgZdt0NLZen6d2vGXuXM
Content-Disposition: inline
In-Reply-To: <20210812123602.76356-1-wangkefeng.wang@huawei.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, uclinux-h8-devel@lists.sourceforge.jp, linux-hexagon@vger.kernel.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-um@lists.infradead.org, linux-mm@kvack.org, Vineet Gupta <vgupta@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Ley Foon Tan <ley.foon.tan@intel.com>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On Thu, Aug 12, 2021 at 08:36:02PM +0800, Kefeng Wang wrote:
> There are some empty trap_init() in different ARCHs, introduce
> a new weak trap_init() function to cleanup them.
> 
> Cc: Vineet Gupta <vgupta@kernel.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Ley Foon Tan <ley.foon.tan@intel.com>
> Cc: Jonas Bonn <jonas@southpole.se>
> Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> Cc: Stafford Horne <shorne@gmail.com>
> Cc: James E.J. Bottomley <James.Bottomley@HansenPartnership.com>
> Cc: Helge Deller <deller@gmx.de>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Paul Walmsley <palmerdabbelt@google.com>
> Cc: Jeff Dike <jdike@addtoit.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

For 32-bit arm:

Acked-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
