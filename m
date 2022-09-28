From: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v2 39/44] cpuidle,clk: Remove trace_.*_rcuidle()
Date: Wed, 28 Sep 2022 11:01:57 -0700
Message-ID: <20220928180159.3512EC4314C@smtp.kernel.org>
References: <20220919095939.761690562@infradead.org> <20220919101522.975285117@infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1664388119;
	bh=+R+5Ns222VYKCsIAXm0EtGUD9zLCQPxIpEujC1GgACo=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=T+jczSmRmP4Jxjbhv5PnAHtWfgjdIVMDvRVFXllGU3Uar4sIJPl+PNHC8v7SBqn9R
	 TJzzWFyZCkLCT1HNMt9sAUZuSZLsznAA4rL6mFHHzFqozKCb0E5JPUr6blFpYaotWd
	 FjnONkJ70opZE0eiBgxOzAPt+zpaayYsakbq2e0o7ogQFF48ymmbK0Tel3A6If0/fr
	 1Agzaag1gHBTm8jFoWO3jg4RjGLm4by83oZrZ08NNFlPE5u2xGrqdvyxoNpVHU9/bY
	 gq89+ULQCWOwAGBGH+gmzfv5n1SxR6G68zYk0n9w/5FlOwHfcKsoAjdntyPP7H0MoA
	 +zhOXdJVALI/w==
In-Reply-To: <20220919101522.975285117@infradead.org>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org>
Content-Type: text/plain; charset="us-ascii"
To: peterz@infradead.org
Cc: juri.lelli@redhat.com, rafael@kernel.org, catalin.marinas@arm.com, linus.walleij@linaro.org, bsegall@google.com, guoren@kernel.org, pavel@ucw.cz, agordeev@linux.ibm.com, srivatsa@csail.mit.edu, linux-arch@vger.kernel.org, vincent.guittot@linaro.org, chenhuacai@kernel.org, linux-acpi@vger.kernel.org, agross@kernel.org, geert@linux-m68k.org, linux-imx@nxp.com, vgupta@kernel.org, mattst88@gmail.com, borntraeger@linux.ibm.com, mturquette@baylibre.com, sammy@sammy.net, pmladek@suse.com, linux-pm@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, linux-um@lists.infradead.org, npiggin@gmail.com, tglx@linutronix.de, linux-omap@vger.kernel.org, dietmar.eggemann@arm.com, andreyknvl@gmail.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, senozhatsky@chromium.org, svens@linux.ibm.com, jolsa@kernel.org, tj@kernel.org, Andrew Morton <akpm@linux-foundation.org>, mar

Quoting Peter Zijlstra (2022-09-19 03:00:18)
> OMAP was the one and only user.
>=20
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
