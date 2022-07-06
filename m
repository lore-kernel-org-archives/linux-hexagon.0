From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 18/36] cpuidle: Annotate poll_idle()
Date: Wed, 6 Jul 2022 16:00:28 +0200
Message-ID: <CAJZ5v0iBAt7xyBzrFwgVSOk7dLx017X_naLZAjnDuwi=oUmREg@mail.gmail.com>
References: <20220608142723.103523089@infradead.org>
 <20220608144517.061583457@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0E1064171E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CE598408BA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B3B0C40B33
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B522240119
In-Reply-To: <20220608144517.061583457@infradead.org>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linus Walleij <linus.walleij@linaro.org>, Benjamin Segall <bsegall@google.com>, Guo Ren <guoren@kernel.org>, Pavel Machek <pavel@ucw.cz>, Alexander Gordeev <agordeev@linux.ibm.com>, linux-arch <linux-arch@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Ellerman <mpe@ellerman.id.au>, Huacai Chen <chenhuacai@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Andy Gross <agross@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, dl-linux-imx <linux-imx@nxp.com>, Catalin Marinas <catalin.marinas@arm.com>, xen-devel@lists.xenproject.org, mattst88@gmail.com, Michael Turquette <mturquette@baylibre.com>, sammy@sammy.net, Petr Mladek <pmladek@suse.com>, Linux PM <linux-pm@vger.kernel.org>, Lai Jiangshan <jiangs>

On Wed, Jun 8, 2022 at 4:46 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> The __cpuidle functions will become a noinstr class, as such they need
> explicit annotations.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/cpuidle/poll_state.c |    6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> --- a/drivers/cpuidle/poll_state.c
> +++ b/drivers/cpuidle/poll_state.c
> @@ -13,7 +13,10 @@
>  static int __cpuidle poll_idle(struct cpuidle_device *dev,
>                                struct cpuidle_driver *drv, int index)
>  {
> -       u64 time_start = local_clock();
> +       u64 time_start;
> +
> +       instrumentation_begin();
> +       time_start = local_clock();
>
>         dev->poll_time_limit = false;
>
> @@ -39,6 +42,7 @@ static int __cpuidle poll_idle(struct cp
>         raw_local_irq_disable();
>
>         current_clr_polling();
> +       instrumentation_end();
>
>         return index;
>  }
>
>
