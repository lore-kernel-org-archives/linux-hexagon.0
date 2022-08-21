From: Huacai Chen <chenhuacai@kernel.org>
Subject: Re: [PATCH] kernel: exit: cleanup release_thread()
Date: Sun, 21 Aug 2022 22:57:53 +0800
Message-ID: <CAAhV-H4qffsU0Tmb7_b0iQh7x3Bks2vVrmmvL+0Z0CVaVggsYg@mail.gmail.com>
References: <20220819014406.32266-1-wangkefeng.wang@huawei.com> <YwIc7qbCWpIVKR2j@arm.com>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661093897;
        bh=GzHlPdU+t+7DtU8s+ZQkqJLPYJa2D5QllpBgFvrmGaw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=f/InbUJweAfp1LwZGHesZqt6a4G8zsWb4eQ8hwBY+fB8ZNzuv2+o+WZHLNeTfA4WO
         tP4Obzfca17jnLVlGgFOFqxNd6GFR4jnIKswxHiVPRByKR0FyyfEjvUWSnMKafFXQ4
         QOr40w20RSDAD9EvrDPFMMrXNqdtlQCXpnGEoCR3w5CIY8AdxOD/JFzlCAcvspGNEm
         DVW630OZ50JWDkTiPs1UE7dtpdaCNgkS+cAO/JlCROhsav5Fnx6kPk1iKt/dCeUOfS
         RZB0YxyQZs+ZabqVHYJ21sh7i3kcM3kQyE6cLB3Q80qen46LSIsGqGB9qTe2iH9WI3
         DNgxHvxgpF3Bw==
In-Reply-To: <YwIc7qbCWpIVKR2j@arm.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>, Richard Henderson <richard.henderson@linaro.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@quicinc.com>, WANG Xuerui <kernel@xen0n.name>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, Mic

For LoongArch parts:

Acked-by: Huacai Chen <chenhuacai@kernel.org>

On Sun, Aug 21, 2022 at 7:54 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Fri, Aug 19, 2022 at 09:44:06AM +0800, Kefeng Wang wrote:
> > Only x86 has own release_thread(), introduce a new weak
> > release_thread() function to clean empty definitions in
> > other ARCHs.
> >
> > Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> [...]
> >  arch/arm64/include/asm/processor.h      | 3 ---
> >  arch/arm64/kernel/process.c             | 4 ----
>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
