From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 08/44] cpuidle,imx6: Push RCU-idle into driver
Date: Tue, 20 Sep 2022 10:58:59 +0200
Message-ID: <YymA0yJybIWLco/v@hirez.programming.kicks-ass.net>
References: <20220919095939.761690562@infradead.org>
 <20220919101520.869531945@infradead.org>
 <20220919142123.GE58444@lothringen>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4B1D760DFA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CECDD60DFE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 79E878198A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4715481980
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=W0WuIu+jUoS9XLKKaCH8kQp1fmQssrlCtEm/el88ozE=; b=KwYybgaPfWAQv2wEUBjSgSdTCJ
 6PyEY99Ugw0TkObX3qDFuI/a0oDFUBfuiBUUHuHbFHFFq6guNqyC3PqWX+KIO/0s8f+cGv+2FQRWg
 rgNBTAgb2XO+egqcRpLHq0uyc6WBOs2BvEht5yDHiFo/J55LY8FWyPdZbShL8Sv2ePJAHnUzVHR4N
 guUt+XkClSTg/oiZERNLhRFjqVw0BFgXrhvLNPplEB/wiXVSXAinmvl5+QTp97eKVQQaYngNgW0RG
 1aMkT/vqgV5rJHRcOsSXww2gbooTZWuewD0FdvxfziqLglppT5CF9GR/zmwpQd6FP4ipquHnML6P4
 smt/leYw==;
Content-Disposition: inline
In-Reply-To: <20220919142123.GE58444@lothringen>
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
To: Frederic Weisbecker <frederic@kernel.org>
Cc: juri.lelli@redhat.com, rafael@kernel.org, catalin.marinas@arm.com, linus.walleij@linaro.org, bsegall@google.com, guoren@kernel.org, pavel@ucw.cz, agordeev@linux.ibm.com, linux-arch@vger.kernel.org, vincent.guittot@linaro.org, mpe@ellerman.id.au, chenhuacai@kernel.org, christophe.leroy@csgroup.eu, linux-acpi@vger.kernel.org, agross@kernel.org, geert@linux-m68k.org, linux-imx@nxp.com, vgupta@kernel.org, mattst88@gmail.com, mturquette@baylibre.com, sammy@sammy.net, pmladek@suse.com, linux-pm@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, linux-um@lists.infradead.org, npiggin@gmail.com, tglx@linutronix.de, linux-omap@vger.kernel.org, dietmar.eggemann@arm.com, andreyknvl@gmail.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, senozhatsky@chromium.org, svens@linux.ibm.com, jolsa@kernel.org, tj@kernel.org, Andrew Morton <a>

On Mon, Sep 19, 2022 at 04:21:23PM +0200, Frederic Weisbecker wrote:
> On Mon, Sep 19, 2022 at 11:59:47AM +0200, Peter Zijlstra wrote:
> > Doing RCU-idle outside the driver, only to then temporarily enable it
> > again, at least twice, before going idle is daft.
> 
> Hmm, what ends up calling RCU_IDLE() here? Also what about
> cpu_do_idle()?

I've ammended patches 5-12 with a comment like:

Notably both cpu_pm_enter() and cpu_cluster_pm_enter() implicity
re-enable RCU.

(each noting the specific sites for the relevant patch).
