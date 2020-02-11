From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH V13] mm/debug: Add tests validating architecture page
 table helpers
Date: Tue, 11 Feb 2020 06:33:47 +0100
Message-ID: <aa540cd6-93a0-1be4-cdff-c9af43ed7d8e@c-s.fr>
References: <1580897674-16456-1-git-send-email-anshuman.khandual@arm.com>
 <202002060619.wEOdAZU1%lkp@intel.com>
 <78d3ce6b-e100-2561-6b09-124c29731d1a@arm.com>
 <20200209205231.44d098f8749e88190b8ba10c@linux-foundation.org>
 <955229f7-f161-f720-0e75-a3163f63817d@arm.com>
 <aef1048f-68c4-d14f-e669-8f288ba9ac7a@c-s.fr>
 <20200210100200.GB25745@shell.armlinux.org.uk>
 <7cb3a5bb-eaea-a01c-4047-e3c000b7ad1d@c-s.fr>
 <20200210110639.GC25745@shell.armlinux.org.uk>
 <82317d50-57a2-ce84-7557-21635d57448e@arm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Mwmnj2Mh3WwfnwZCWtQm8v+ZNM5AU+v+3fKB+Vt+2i0=; b=F3a/zO2JTWGdCJ
	miwEytUPvBf2VCMINkj5EwlXhXKb0umJ9W1SR/0OneLzNKYhGegUHFpqAByFXXwWr81c4d7sonkvT
	4Tl2efrMSYde3nw2zPIWrTQ5vI2UDyfVXxG+eXoMhDSjFXQX7vlHICnFBXLEMQ3SZY1RuwxonQkgN
	AHCX7jBDeyNLBhAOSSZmnwjvv+jbh6MjzlDSg6bFjnJrOjf0ARyMrvFdoA6E5IZ6+pw4ptY0Zx4Qf
	cAa+LiP0TEIgjJjvbcIjfW0uM0wY/n9c/Fo5shBN3ir+4pXKsLOTFdNXVgwqqyoD1JrJyBUbovUYh
	ImiD6D5117u6k/smrmtA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1581399230; bh=Mwmnj2Mh3WwfnwZCWtQm8v+ZNM5AU+v+3fKB+Vt+2i0=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=eiJDqafSfDYphjROC10Vnz8Xn4zZIPklngVdYVaguBX5QmUxSbROO5kAJ30wvAhzg
 0fV39U/k7ykq9c6fVHRsjt4aiC/Qv+CenzoBQFemfXJIaflYEGRvsm8/278XrXInkJ
 zdjMm7FlftlG1Bdd/ww1KQhN8+LUDsKmilPkcQWI=
In-Reply-To: <82317d50-57a2-ce84-7557-21635d57448e@arm.com>
Content-Language: fr
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org
Content-Type: text/plain; charset="utf-8"; format="flowed"
To: Anshuman Khandual <anshuman.khandual@arm.com>, Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc: Mark Rutland <mark.rutland@arm.com>, uclinux-h8-devel@lists.sourceforge.jp, linux-m68k@vger.kernel.org, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, James Hogan <jhogan@kernel.org>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Heiko Carstens <heiko.carstens@de.ibm.com>, Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org, Dave Hansen <dave.hansen@intel.com>, Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-riscv@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>, linux-s390@vger.kernel.org, kbuild test robot <lkp@intel.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Max Filippov <jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org, Matthew Wilcox <willy@infradead.org>, Steven Price <Steven.Price@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>



Le 11/02/2020 à 03:25, Anshuman Khandual a écrit :
> 
> 
> On 02/10/2020 04:36 PM, Russell King - ARM Linux admin wrote:
>> There are good reasons for the way ARM does stuff.  The generic crap was
>> written without regard for the circumstances that ARM has, and thus is
>> entirely unsuitable for 32-bit ARM.
> 
> Since we dont have an agreement here, lets just settle with disabling the
> test for now on platforms where the build fails. CONFIG_EXPERT is enabling
> this test for better adaptability and coverage, hence how about re framing
> the config like this ? This at the least conveys the fact that EXPERT only
> works when platform is neither IA64 or ARM.

Agreed

> 
> config DEBUG_VM_PGTABLE
> 	bool "Debug arch page table for semantics compliance"
> 	depends on MMU
> 	depends on ARCH_HAS_DEBUG_VM_PGTABLE || (EXPERT &&  !(IA64 || ARM))

I think it's maybe better to have a dedicated depends line:

depends on !IA64 && !ARM
depends on ARCH_HAS_DEBUG_VM_PGTABLE || EXPERT

The day arm and/or ia64 is ready for building the test, we can remove 
that depends.

> 	default n if !ARCH_HAS_DEBUG_VM_PGTABLE
> 	default y if DEBUG_VM
> 

Christophe

