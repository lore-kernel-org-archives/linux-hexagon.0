From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 09/44] cpuidle,omap3: Push RCU-idle into driver
Date: Mon, 19 Sep 2022 17:19:05 +0200
Message-ID: <YyiIaeQY8STLK0d0@hirez.programming.kicks-ass.net>
References: <20220919095939.761690562@infradead.org>
 <20220919101520.936337959@infradead.org>
 <20220919143142.GA61009@lothringen>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6974A60B6E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B698C60A68
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CCBC540BA8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 08EAB40B56
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=jX68leu2S48Jr9/Ow8JXapSFFP60f/i61NXz6aPsf+I=; b=XPfGWCYBJlDbJ5lJcPaNDE6xyf
 Oko/uZ8RNini73nyposkKJ862RPOu3iJTh8zG5Pep4a2VS0ERxBpWJvvYT8T14rg88H9wegspg5bu
 9yb2vdL1erAt0tTaRycHKMCoHV1yhzX6AKI/cj+ny97aRfzpr5jWq/LiOBfEwvZYLisXl+Yo5byp9
 Uk9NM6k+rmDmbbvvXH1mJtohRq1/Mc/o3s0t/ScSKJIDftdo6lQTij50ttW7F88bRo1TeESDSO6Qa
 lgAptah2KzLlw6pLcJo2JiZ0q/deK2kHiqFB9rLjmKuXizDSL1Hi2Yh+pFPur3R2mMtDZOGx295rw
 A79DBNeg==;
Content-Disposition: inline
In-Reply-To: <20220919143142.GA61009@lothringen>
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

On Mon, Sep 19, 2022 at 04:31:42PM +0200, Frederic Weisbecker wrote:
> On Mon, Sep 19, 2022 at 11:59:48AM +0200, Peter Zijlstra wrote:
> > Doing RCU-idle outside the driver, only to then teporarily enable it
> > again before going idle is daft.
> 
> That doesn't tell where those calls are.

cpu_pm_enter/exit and the power domain stuff, possibly also the clock
domain stuff. It's all over :/

I suppose I can add a blub and copy/paste it around the various patches
if you want.
