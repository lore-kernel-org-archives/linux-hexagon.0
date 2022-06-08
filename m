From: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 36/36] cpuidle,clk: Remove trace_.*_rcuidle()
Date: Wed, 08 Jun 2022 13:03:13 -0700
Message-ID: <20220608200315.0DFC6C34116@smtp.kernel.org>
References: <20220608142723.103523089@infradead.org> <20220608144518.199614455@infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1654718595;
	bh=YZj1RmoUZo+LYT5ptsLh5yk+BpSbCXtp2v5Q3jvJ2yk=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=rOeLrE8rnpKlWp1L6QV8jwDsJJaMtcMr7WDG2/vqLSawxjnGItPceVZFlHTUrnWyn
	 9+efmotoys2/zcmyQ+2SiY2vmlncrC9YSx9eX2LtQ3gTK4bn8zXIJLPC3S1yBpMZZw
	 2qreZHAHeGZgvi1VuNxh+OEn8aBYZhVnWOgh8n+AYCKFEvGc8lv11v15OZafMlMiPE
	 0xDVpRNMj8gOLpIXJeYzglBnvFvkh+GCkt4QDHid18PobTg6Mb0qcnz3/6cipnr2To
	 eQCv7sinD98qIhIYXSEjsJPBZidTnTnYxN2cPw54PLu4ECKoLyinDEhUapDw9DnRAK
	 XLR4CpCut9s5A==
In-Reply-To: <20220608144518.199614455@infradead.org>
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
Cc: juri.lelli@redhat.com, rafael@kernel.org, linus.walleij@linaro.org, bsegall@google.com, guoren@kernel.org, pavel@ucw.cz, agordeev@linux.ibm.com, srivatsa@csail.mit.edu, linux-arch@vger.kernel.org, vincent.guittot@linaro.org, chenhuacai@kernel.org, linux-acpi@vger.kernel.org, agross@kernel.org, geert@linux-m68k.org, linux-imx@nxp.com, catalin.marinas@arm.com, xen-devel@lists.xenproject.org, mattst88@gmail.com, borntraeger@linux.ibm.com, mturquette@baylibre.com, sammy@sammy.net, pmladek@suse.com, linux-pm@vger.kernel.org, jiangshanlai@gmail.com, Sascha Hauer <s.hauer@pengutronix.de>, linux-um@lists.infradead.org, acme@kernel.org, tglx@linutronix.de, linux-omap@vger.kernel.org, dietmar.eggemann@arm.com, rth@twiddle.net, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, senozhatsky@chromium.org, t@lists.ozlabs.org, jolsa@kernel.org

Quoting Peter Zijlstra (2022-06-08 07:27:59)
> OMAP was the one and only user.
>=20
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
