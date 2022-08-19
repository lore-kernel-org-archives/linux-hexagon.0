From: "Russell King (Oracle)" <linux@armlinux.org.uk>
Subject: Re: [PATCH] kernel: exit: cleanup release_thread()
Date: Fri, 19 Aug 2022 15:55:28 +0100
Message-ID: <Yv+kYPnf8c6rLXgN@shell.armlinux.org.uk>
References: <20220819014406.32266-1-wangkefeng.wang@huawei.com>
Mime-Version: 1.0
Return-path: <linux-mips-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=SYqd0jVvSqn0LYdbb0mNobM+NLD0i8990uNItjrpJW0=; b=p8X1gMssAFqz7Cj5E1IU3EN3xz
        t/snbLEyJv1XAdu4J+MpAgDpW86NPkUeqqsmS64YxuYIDoz1/0nSwGnJ4A7MRHs6v4/DfY13yylRH
        yTpJ3gDO1i4G6ew5SrDgljBdNE61ShqeAK0joibG/N9CQrD4C5DO+D+oHobsM0kWRo/T88yRl68DM
        ivZpQK7KoicNncKbbL3cMwzclIbdo4NBfFt8WVkYbV7Yt9Ti+iBnKi0iAa3qakANtULKlnjVs0VPW
        qMm4R7XYp2iFBesGctz7KWjgzPu53WYvs3CSQtaYwSCE20OErGTcffzJDbyUtNOmEl2QCsbCVzRVd
Content-Disposition: inline
In-Reply-To: <20220819014406.32266-1-wangkefeng.wang@huawei.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@quicinc.com>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, Mic

On Fri, Aug 19, 2022 at 09:44:06AM +0800, Kefeng Wang wrote:
> Only x86 has own release_thread(), introduce a new weak
> release_thread() function to clean empty definitions in
> other ARCHs.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
...
>  arch/arm/include/asm/processor.h        | 3 ---
>  arch/arm/kernel/process.c               | 4 ----

Acked-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
