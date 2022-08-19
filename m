From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] kernel: exit: cleanup release_thread()
Date: Fri, 19 Aug 2022 11:40:14 +0200
Message-ID: <CAMuHMdUd5Ww-mtpymykuahHWD+S62Z8qiBMVx8y4okouuzTCAg@mail.gmail.com>
References: <20220819014406.32266-1-wangkefeng.wang@huawei.com>
Mime-Version: 1.0
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <20220819014406.32266-1-wangkefeng.wang@huawei.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@quicinc.com>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, Michael

Hi Kefeng,

On Fri, Aug 19, 2022 at 3:39 AM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> Only x86 has own release_thread(), introduce a new weak
> release_thread() function to clean empty definitions in
> other ARCHs.
>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

>  arch/m68k/include/asm/processor.h       | 5 -----

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -183,6 +183,10 @@ void put_task_struct_rcu_user(struct task_struct *task)
>                 call_rcu(&task->rcu, delayed_put_task_struct);
>  }
>
> +void __weak release_thread(struct task_struct *dead_task)
> +{
> +}

As the default implementation is empty, it might be better to keep
this as a static inline function, protected by #ifndef release_thread,
and let x86 #define release_thread.

> +
>  void release_task(struct task_struct *p)
>  {
>         struct task_struct *leader;

Gr{oetje,eeting}s,

                        Geert
