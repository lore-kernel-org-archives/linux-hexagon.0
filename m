From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: [PATCH V13] mm/debug: Add tests validating architecture page
 table helpers
Date: Tue, 11 Feb 2020 09:24:48 +0000
Message-ID: <20200211092448.GI25745@shell.armlinux.org.uk>
References: <202002060619.wEOdAZU1%lkp@intel.com>
 <78d3ce6b-e100-2561-6b09-124c29731d1a@arm.com>
 <20200209205231.44d098f8749e88190b8ba10c@linux-foundation.org>
 <955229f7-f161-f720-0e75-a3163f63817d@arm.com>
 <aef1048f-68c4-d14f-e669-8f288ba9ac7a@c-s.fr>
 <20200210100200.GB25745@shell.armlinux.org.uk>
 <7cb3a5bb-eaea-a01c-4047-e3c000b7ad1d@c-s.fr>
 <20200210110639.GC25745@shell.armlinux.org.uk>
 <82317d50-57a2-ce84-7557-21635d57448e@arm.com>
 <aa540cd6-93a0-1be4-cdff-c9af43ed7d8e@c-s.fr>
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
	List-Owner; bh=IEweK1Oe6le969jj6/9ySSvupCzyT07lVN1MEsV+j8U=; b=m8oU2T4leVwjun
	XgvIknlloBoeRz1uO5JRqK8+kQpQykRJBALjNS1NvrDwfhkTsGlfL4e5cfwF2F06M2EUfgxKkIfmn
	shRhh8oRqhY+G7BCaoN1hCXt+tBnMPlDGonya8WStJc0dhTjzoiqALp2oOJMODSsJoc2VhM1oFow+
	sO5AZz1ETAol5E5vajcTPPy6UfGFK7ByYDytyh9N2wnlsBU2+Mes7cQjLuyLaZgG4zDG62P+TV15z
	v7wjqReBxEkOu6JTjMD868vtSrNVcIiPOTftuZ1oQiRMHtYsWs88EsasdTVTlQvOuQjMgG2v0KunE
	KBprGQVPx9W6SANzpSYg==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
 Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=t+QeGYCEkcUs6b5ZM+NOCwDbOmiMQnW8+LwY6bloPz4=; b=qjHd2cY4lTS/cb7bo4SP21lEI
 sUw+WwOCTcr39efAZGJoSf5pc1rkF99mBPElJh5dxtxrVXkd5r8pZ35M3ZfVodX8d45wYDbdrWO0J
 obey6q5d1eoDdzy+zGQoBw5EdxokxL4V8Mqrm7+DwCQhVJE0SpExjvX1qu/Rr98SN6lpOpUPiz2SK
 Fo8muWV7WCBNkIipNrx1cXJrdbQhgjhUVCjm9k1TQTH0PBfFMstbJP/LB7eavJb67MdKLpZ/i7Fx+
 7xOdkDULV9Ftpxwe57kIuG/nvVpEp+3i9oni28P56FkXFFyOxHOLqnr33ssRmsiyeDJNxiWaPVYmm
 0QKe2yYMg==;
Content-Disposition: inline
In-Reply-To: <aa540cd6-93a0-1be4-cdff-c9af43ed7d8e@c-s.fr>
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

On Tue, Feb 11, 2020 at 06:33:47AM +0100, Christophe Leroy wrote:
> =

> =

> Le 11/02/2020 =E0 03:25, Anshuman Khandual a =E9crit=A0:
> > =

> > =

> > On 02/10/2020 04:36 PM, Russell King - ARM Linux admin wrote:
> > > There are good reasons for the way ARM does stuff.  The generic crap =
was
> > > written without regard for the circumstances that ARM has, and thus is
> > > entirely unsuitable for 32-bit ARM.
> > =

> > Since we dont have an agreement here, lets just settle with disabling t=
he
> > test for now on platforms where the build fails. CONFIG_EXPERT is enabl=
ing
> > this test for better adaptability and coverage, hence how about re fram=
ing
> > the config like this ? This at the least conveys the fact that EXPERT o=
nly
> > works when platform is neither IA64 or ARM.
> =

> Agreed
> =

> > =

> > config DEBUG_VM_PGTABLE
> > 	bool "Debug arch page table for semantics compliance"
> > 	depends on MMU
> > 	depends on ARCH_HAS_DEBUG_VM_PGTABLE || (EXPERT &&  !(IA64 || ARM))
> =

> I think it's maybe better to have a dedicated depends line:
> =

> depends on !IA64 && !ARM
> depends on ARCH_HAS_DEBUG_VM_PGTABLE || EXPERT
> =

> The day arm and/or ia64 is ready for building the test, we can remove that
> depends.

Never going to happen as its technically infeasible, sorry.

-- =

RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps =
up
According to speedtest.net: 11.9Mbps down 500kbps up
