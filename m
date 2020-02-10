From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: [PATCH V13] mm/debug: Add tests validating architecture page
 table helpers
Date: Mon, 10 Feb 2020 10:02:00 +0000
Message-ID: <20200210100200.GB25745@shell.armlinux.org.uk>
References: <1580897674-16456-1-git-send-email-anshuman.khandual@arm.com>
 <202002060619.wEOdAZU1%lkp@intel.com>
 <78d3ce6b-e100-2561-6b09-124c29731d1a@arm.com>
 <20200209205231.44d098f8749e88190b8ba10c@linux-foundation.org>
 <955229f7-f161-f720-0e75-a3163f63817d@arm.com>
 <aef1048f-68c4-d14f-e669-8f288ba9ac7a@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JQXIjUGy6WE9nMgl6ZO64yy2Xv4u60N+MAKrVDXnLLc=; b=sV4ghq/6c36HUh
	Hy6snz/wLrW2Z5DeCLODUChsAazAh3wR0AnWlEXsyaGBX8t8cY+N0KaxfWjPwfvM84cvCkMU4hShH
	lK6nxAkBeGBqW/EDzNGBJW3sKKVWlvy01EZYh1z8p3v+svZNIxqS6ekLi3WXY07T8JxZs642oeDGz
	dv9T4TxDCgvr3Eh4zcTg4Ha9Tu3sM3+WBaE1Ok3s5vybgCIjBXS5PE3GR15tyo1gA67qQbX4zgUiu
	Pr+tAUjkJi1poLKNMOHZpAcXr0BwyybMmemNZ2zM/HQom5m8hDPpQWpDNc7T5okkfaC0fwKjDrU5n
	KiEpotaybzKmxZcSUnTw==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
 Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RSn3HWq+fQx3mvRzpzEy/ZPYio+au3Nj4p8Sb6VpYxo=; b=eqx3n038MyxRXaqi7Kct7sCzG
 VhpGovtk9XW4/PoewLuofpbmfNeF4SIGAZWl0dzhvA1ZQ3Vft+3ccFCAdSlX+ao4iyGr6hvFS6d42
 2wRbqFB2axc0IYHndR1Y9zua9iKJ9bA7wt34Do5ieTN+1QbJh6Z5NwlMy2q7sO8hgei4U2NjJLont
 hKWveKOWLIlb/Pwt3rVgBRGsdYHT5TD1MxKMWbMU6yalM70vxDxUBTTsbhY9FBLK6V00td+E89zDt
 LduRjtUpGZZ8DACE/idSdyyKfqNc6dRHgBpdQ3JbYrmB34mzV2TQcqZUZsINTYBPqcFSUpox1sJud
 AFyPSs9GA==;
Content-Disposition: inline
In-Reply-To: <aef1048f-68c4-d14f-e669-8f288ba9ac7a@c-s.fr>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>, 
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>, 
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane-mx.org@lists.infradead.org
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Mark Rutland <mark.rutland@arm.com>, uclinux-h8-devel@lists.sourceforge.jp, linux-m68k@vger.kernel.org, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, James Hogan <jhogan@kernel.org>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Heiko Carstens <heiko.carstens@de.ibm.com>, Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-riscv@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>, linux-s390@vger.kernel.org, kbuild test robot <lkp@intel.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Max Filippov <jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org, Matthew Wilcox <willy@infradead.org>, Steven Price <Steven.Price@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Geert Uytterhoeven <geert@linux-m6>

On Mon, Feb 10, 2020 at 07:38:38AM +0100, Christophe Leroy wrote:
> =

> =

> Le 10/02/2020 =E0 06:35, Anshuman Khandual a =E9crit=A0:
> > =

> > =

> > On 02/10/2020 10:22 AM, Andrew Morton wrote:
> > > On Thu, 6 Feb 2020 13:49:35 +0530 Anshuman Khandual <anshuman.khandua=
l@arm.com> wrote:
> > > =

> > > > =

> > > > On 02/06/2020 04:40 AM, kbuild test robot wrote:
> > > > > Hi Anshuman,
> > > > > =

> > > > > Thank you for the patch! Yet something to improve:
> > > > > =

> > > > > [auto build test ERROR on powerpc/next]
> > > > > [also build test ERROR on s390/features linus/master arc/for-next=
 v5.5]
> > > > > [cannot apply to mmotm/master tip/x86/core arm64/for-next/core ne=
xt-20200205]
> > > > > [if your patch is applied to the wrong git tree, please drop us a=
 note to help
> > > > > improve the system. BTW, we also suggest to use '--base' option t=
o specify the
> > > > > base tree in git format-patch, please see https://stackoverflow.c=
om/a/37406982]
> > > > > =

> > > > > url:    https://github.com/0day-ci/linux/commits/Anshuman-Khandua=
l/mm-debug-Add-tests-validating-architecture-page-table-helpers/20200205-21=
5507
> > > > > base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/l=
inux.git next
> > > > > config: ia64-allmodconfig (attached as .config)
> > > > > compiler: ia64-linux-gcc (GCC) 7.5.0
> > > > > reproduce:
> > > > >          wget https://raw.githubusercontent.com/intel/lkp-tests/m=
aster/sbin/make.cross -O ~/bin/make.cross
> > > > >          chmod +x ~/bin/make.cross
> > > > >          # save the attached .config to linux build tree
> > > > >          GCC_VERSION=3D7.5.0 make.cross ARCH=3Dia64
> > > > > =

> > > > > If you fix the issue, kindly add following tag
> > > > > Reported-by: kbuild test robot <lkp@intel.com>
> > > > > =

> > > > > All error/warnings (new ones prefixed by >>):
> > > > > =

> > > > >     In file included from include/asm-generic/pgtable-nopud.h:8:0,
> > > > >                      from arch/ia64/include/asm/pgtable.h:586,
> > > > >                      from include/linux/mm.h:99,
> > > > >                      from include/linux/highmem.h:8,
> > > > >                      from mm/debug_vm_pgtable.c:14:
> > > > >     mm/debug_vm_pgtable.c: In function 'pud_clear_tests':
> > > > > > > include/asm-generic/pgtable-nop4d-hack.h:47:32: error: implic=
it declaration of function '__pgd'; did you mean '__p4d'? [-Werror=3Dimplic=
it-function-declaration]
> > > > >      #define __pud(x)    ((pud_t) { __pgd(x) })
> > > > >                                     ^
> > > > > > > mm/debug_vm_pgtable.c:141:8: note: in expansion of macro '__p=
ud'
> > > > >       pud =3D __pud(pud_val(pud) | RANDOM_ORVALUE);
> > > > >             ^~~~~
> > > > > > > include/asm-generic/pgtable-nop4d-hack.h:47:22: warning: miss=
ing braces around initializer [-Wmissing-braces]
> > > > >      #define __pud(x)    ((pud_t) { __pgd(x) })
> > > > >                           ^
> > > > > > > mm/debug_vm_pgtable.c:141:8: note: in expansion of macro '__p=
ud'
> > > > >       pud =3D __pud(pud_val(pud) | RANDOM_ORVALUE);
> > > > >             ^~~~~
> > > > >     cc1: some warnings being treated as errors
> > > > =

> > > > This build failure is expected now given that we have allowed DEBUG=
_VM_PGTABLE
> > > > with EXPERT without platform requiring ARCH_HAS_DEBUG_VM_PGTABLE. T=
his problem
> > > > i.e build failure caused without a platform __pgd(), is known to ex=
ist both on
> > > > ia64 and arm (32bit) platforms. Please refer https://lkml.org/lkml/=
2019/9/24/314
> > > > for details where this was discussed earlier.
> > > > =

> > > =

> > > I'd prefer not to merge a patch which is known to cause build
> > > regressions.  Is there some temporary thing we can do to prevent these
> > > errors until arch maintainers(?) get around to implementing the
> > > long-term fixes?
> > =

> > We could explicitly disable CONFIG_DEBUG_VM_PGTABLE on ia64 and arm pla=
tforms
> > which will ensure that others can still use the EXPERT path.
> > =

> > config DEBUG_VM_PGTABLE
> > 	bool "Debug arch page table for semantics compliance"
> > 	depends on MMU
> > 	depends on !(IA64 || ARM)
> > 	depends on ARCH_HAS_DEBUG_VM_PGTABLE || EXPERT
> > 	default n if !ARCH_HAS_DEBUG_VM_PGTABLE
> > 	default y if DEBUG_VM
> > =

> =

> On both ia32 and arm, the fix is trivial.
> =

> Can we include the fix within this patch, just the same way as the
> mm_p4d_folded() fix for x86 ?

Why should arm include a macro for something that nothing (apart from
this checker) requires?  If the checker requires it but the rest of
the kernel does not, it suggests that the checker isn't actually
correct, and the results can't be relied upon.

-- =

RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps =
up
According to speedtest.net: 11.9Mbps down 500kbps up
