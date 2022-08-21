From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] kernel: exit: cleanup release_thread()
Date: Sun, 21 Aug 2022 12:54:22 +0100
Message-ID: <YwIc7qbCWpIVKR2j@arm.com>
References: <20220819014406.32266-1-wangkefeng.wang@huawei.com>
Mime-Version: 1.0
Return-path: <linux-alpha-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20220819014406.32266-1-wangkefeng.wang@huawei.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@quicinc.com>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, Michael

On Fri, Aug 19, 2022 at 09:44:06AM +0800, Kefeng Wang wrote:
> Only x86 has own release_thread(), introduce a new weak
> release_thread() function to clean empty definitions in
> other ARCHs.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
[...]
>  arch/arm64/include/asm/processor.h      | 3 ---
>  arch/arm64/kernel/process.c             | 4 ----

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
