From: Vineet Gupta <vgupta@kernel.org>
Subject: Re: [PATCH -next] trap: Cleanup trap_init()
Date: Thu, 12 Aug 2021 11:57:49 -0700
Message-ID: <b49eed44-0837-906c-8779-4fffb5609653@kernel.org>
References: <20210812123602.76356-1-wangkefeng.wang@huawei.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-parisc-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628794671;
        bh=9lyFwGGuyLf5GdDUz/aKvERlOFF1uWuGiPBbUIAEKfE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=VwLU2IBE7pm2CpqhWrWcs09zHfDgGQQ+XwYJ0x4NJ+OYptETg8cUHpeJuXviSEb8m
         hZwv3aN1LfVIwHZVS+UQ7mB1srMgVxwRZcSfRTFv67A2WL07AvZbrPj/Jz8MICDjiz
         tSsLyZBkRPIi4PEfw72QWFlCzfTyNhyHc6hoJdLtBX/ALr48Ij7oskYZxfFb8gVUAz
         MdoO56PMOMA1qSMNTQQWl/YJOfRCSFiinLi5nd/tFripDrfTPOSzz5IN+8rkyBTJL5
         ClZ1UH9RZQQUjhvz/MyHpPFG2IOOryYDriDcsJsaN4YgRfyjgsTyLvyz3NzaOYphUa
         cYgcKsD4gQWUw==
In-Reply-To: <20210812123602.76356-1-wangkefeng.wang@huawei.com>
Content-Language: en-US
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
To: Kefeng Wang <wangkefeng.wang@huawei.com>, linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, uclinux-h8-devel@lists.sourceforge.jp, linux-hexagon@vger.kernel.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-um@lists.infradead.org, linux-mm@kvack.org
Cc: Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, Yoshinori Sato <ysato@users.sourceforge.jp>, Ley Foon Tan <ley.foon.tan@intel.com>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Paul Walmsley <palmerdabbelt@google.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Andrew Morton <akpm@linux-foundation.org>

On 8/12/21 5:36 AM, Kefeng Wang wrote:
> There are some empty trap_init() in different ARCHs, introduce
> a new weak trap_init() function to cleanup them.
>
> Cc: Vineet Gupta<vgupta@kernel.org>
> Cc: Russell King<linux@armlinux.org.uk>
> Cc: Yoshinori Sato<ysato@users.sourceforge.jp>
> Cc: Ley Foon Tan<ley.foon.tan@intel.com>
> Cc: Jonas Bonn<jonas@southpole.se>
> Cc: Stefan Kristiansson<stefan.kristiansson@saunalahti.fi>
> Cc: Stafford Horne<shorne@gmail.com>
> Cc: James E.J. Bottomley<James.Bottomley@HansenPartnership.com>
> Cc: Helge Deller<deller@gmx.de>
> Cc: Michael Ellerman<mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt<benh@kernel.crashing.org>
> Cc: Paul Mackerras<paulus@samba.org>
> Cc: Paul Walmsley<palmerdabbelt@google.com>
> Cc: Jeff Dike<jdike@addtoit.com>
> Cc: Richard Weinberger<richard@nod.at>
> Cc: Anton Ivanov<anton.ivanov@cambridgegreys.com>
> Cc: Andrew Morton<akpm@linux-foundation.org>
> Signed-off-by: Kefeng Wang<wangkefeng.wang@huawei.com>
> ---
>   arch/arc/kernel/traps.c      | 5 -----

Acked-by: Vineet Gupta <vgupt@kernel.org>=C2=A0 #arch/arc
