From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v5 2/4] kgdb: Fix kgdb_roundup_cpus() for arches who used smp_call_function()
Date: Tue, 27 Nov 2018 09:39:09 -0800
Message-ID: <CAD=FV=V087x+56aWFtJxg31O09cFUm00grH7bq1rLSwoq68WdA@mail.gmail.com>
References: <20181127035133.225592-3-dianders@chromium.org> <201811271333.8ZTVxYUT%fengguang.wu@intel.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SxG22gKp3uE4WIbzN+Oih1tHSp7o6ihhKSzDyg1OL+k=;
        b=n8Ig5tAbA7o3/Ez/WMYwOM6FQ8Y7htlXMticvVSwbTd68NwdFgyL/WgOnsMP1ni1pW
         +STDRZ2AFIiJAy+B5Z9uUEyF+oxnMtVjLcHdm9Hmx/v9AvHS61VlBIbAUOani6h8lpAJ
         yz3zvL8AcXhbiLN04crZSzLzeHZC9ti8UKCIw=
In-Reply-To: <201811271333.8ZTVxYUT%fengguang.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, Jason Wessel <jason.wessel@windriver.com>, Daniel Thompson <daniel.thompson@linaro.org>, Will Deacon <will.deacon@arm.com>, kgdb-bugreport@lists.sourceforge.net, Peter Zijlstra <peterz@infradead.org>, linux-mips@linux-mips.org, linux-sh@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, jhogan@kernel.org, linux-hexagon@vger.kernel.org, Vineet Gupta <vgupta@synopsys.com>, dalias@libc.org, Ralf Baechle <ralf@linux-mips.org>, linux-snps-arc@lists.infradead.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, paulus@samba.org, Russell King - ARM Linux <linux@armlinux.org.uk>, Linux ARM <linux-arm-kernel@lists.infradead.org>, christophe.leroy@c-s.fr, mpe@eller

Hi,

On Mon, Nov 26, 2018 at 9:39 PM kbuild test robot <lkp@intel.com> wrote:
>
> Hi Douglas,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on kgdb/kgdb-next]
> [also build test ERROR on v4.20-rc4 next-20181126]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Douglas-Anderson/kgdb-Fix-kgdb_roundup_cpus/20181127-115425
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/jwessel/kgdb.git kgdb-next
> config: sparc64-allyesconfig (attached as .config)
> compiler: sparc64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.2.0 make.cross ARCH=sparc64
>
> Note: the linux-review/Douglas-Anderson/kgdb-Fix-kgdb_roundup_cpus/20181127-115425 HEAD b8d0502e65f2d7a2187baa69870146a6fbf18c9f builds fine.
>       It only hurts bisectibility.
>
> All errors (new ones prefixed by >>):
>
>    kernel/debug/debug_core.c: In function 'kgdb_roundup_cpus':
> >> kernel/debug/debug_core.c:261:18: error: 'struct debuggerinfo_struct' has no member named 'rounding_up'
>        kgdb_info[cpu].rounding_up = false;
>                      ^

Oops, I squashed this into the wrong patch.  It should have been in
patch #3.  Sorry about that.  I'll send out a quick v6.
