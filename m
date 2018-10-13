From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH 0/4] Add support for fast mremap
Date: Fri, 12 Oct 2018 18:31:56 -0700
Message-ID: <20181013013200.206928-1-joel@joelfernandes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=WqfF1osfz3odJ6JisQVd+yQEnCfayUSwhL7gk2pPWbM=; b=bwCabPjZEW0lja
	mH1Ujfsgj1+AsALI3Jufake9GCe4m7CjcXCcGfD3Ged0AWiABinUUa+W0vooUkRUY3+91JT6Kxbe9
	N0UFRnfVzBrmY/1i4lZEyvIuUSpHGkjruEzzKv3dpXc86ocHzC+koibn3KJrHXoFtBCP+fkMxcrnc
	M8NNrjqToWkBZnltHHx7DpvBAy9B7Cb2+cu3v5lJX3E+oxgqgyL0TLsk7JgNVmtWuBUQqQVAr6g/B
	pUERSHhe/1PEIVMXkISIgfHx0D8Pa6KGVX+h+aZwza6U/hVw48RmwlHdWbkMyp+hw7mFRc4eJVrDE
	dqsb9kzF4VsF0G/CShBg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=joelfernandes.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/tt52pA472dSwsAAwQJ939rJwzTfqkSaNx9EwvICru0=;
 b=aZ2XsHZUVMUuO5DvSG7J3SKtJwMjFPFkNKSdOTMVPxEWZUBHqCq91bWsY5lJSZ5abW
 MspF88SV9xG3kBt1cxNpgjwLM9fjqG9Qr8THIveYjgxWMmIJI/3CsoQ1euVVO+u9jU3b
 84AjE6qoveKMUd+TSCAUYFppegkJuFE12F9Zo=
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>, 
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>, 
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-mips@linux-mips.org, Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, Will Deacon <will.deacon@arm.com>, mhocko@kernel.org, linux-mm@kvack.org, lokeshgidra@google.com, "Joel Fernandes (Google)" <joel@joelfernandes.org>, linux-riscv@lists.infradead.org, elfring@users.sourceforge.net, Jonas Bonn <jonas@southpole.se>, kvmarm@lists.cs.columbia.edu, dancol@google.com, Yoshinori Sato <ysato@users.sourceforge.jp>, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-hexagon@vger.kernel.org, Helge Deller <deller@gmx.de>, "maintainer:X86 ARCHITECTURE 32-BIT AND 64-BIT" <x86@kernel.org>, hughd@google.com, "James E.J. Bottomley" <jejb@parisc-linux.org>, kasan-dev@googlegroups.com, anton.ivanov@kot-begem

Hi,
Here is the latest "fast mremap" series. The main change in this submission is
to enable the fast mremap optimization on a per-architecture basis to prevent
possible issues with architectures that may not behave well with such change.

x86: select HAVE_MOVE_PMD for faster mremap (v1)

arm64: select HAVE_MOVE_PMD for faster mremap (v1)

mm: speed up mremap by 500x on large regions (v2)
v1->v2: Added support for per-arch enablement (Kirill Shutemov)

treewide: remove unused address argument from pte_alloc functions (v2)
v1->v2: fix arch/um/ prototype which was missed in v1 (Anton Ivanov)
        update changelog with manual fixups for m68k and microblaze.

Joel Fernandes (Google) (4):
  treewide: remove unused address argument from pte_alloc functions (v2)
  mm: speed up mremap by 500x on large regions (v2)
  arm64: select HAVE_MOVE_PMD for faster mremap (v1)
  x86: select HAVE_MOVE_PMD for faster mremap (v1)

 arch/Kconfig                                 |  5 ++
 arch/alpha/include/asm/pgalloc.h             |  6 +-
 arch/arc/include/asm/pgalloc.h               |  5 +-
 arch/arm/include/asm/pgalloc.h               |  4 +-
 arch/arm64/Kconfig                           |  1 +
 arch/arm64/include/asm/pgalloc.h             |  4 +-
 arch/hexagon/include/asm/pgalloc.h           |  6 +-
 arch/ia64/include/asm/pgalloc.h              |  5 +-
 arch/m68k/include/asm/mcf_pgalloc.h          |  8 +--
 arch/m68k/include/asm/motorola_pgalloc.h     |  4 +-
 arch/m68k/include/asm/sun3_pgalloc.h         |  6 +-
 arch/microblaze/include/asm/pgalloc.h        | 19 +-----
 arch/microblaze/mm/pgtable.c                 |  3 +-
 arch/mips/include/asm/pgalloc.h              |  6 +-
 arch/nds32/include/asm/pgalloc.h             |  5 +-
 arch/nios2/include/asm/pgalloc.h             |  6 +-
 arch/openrisc/include/asm/pgalloc.h          |  5 +-
 arch/openrisc/mm/ioremap.c                   |  3 +-
 arch/parisc/include/asm/pgalloc.h            |  4 +-
 arch/powerpc/include/asm/book3s/32/pgalloc.h |  4 +-
 arch/powerpc/include/asm/book3s/64/pgalloc.h | 12 ++--
 arch/powerpc/include/asm/nohash/32/pgalloc.h |  4 +-
 arch/powerpc/include/asm/nohash/64/pgalloc.h |  6 +-
 arch/powerpc/mm/pgtable-book3s64.c           |  2 +-
 arch/powerpc/mm/pgtable_32.c                 |  4 +-
 arch/riscv/include/asm/pgalloc.h             |  6 +-
 arch/s390/include/asm/pgalloc.h              |  4 +-
 arch/sh/include/asm/pgalloc.h                |  6 +-
 arch/sparc/include/asm/pgalloc_32.h          |  5 +-
 arch/sparc/include/asm/pgalloc_64.h          |  6 +-
 arch/sparc/mm/init_64.c                      |  6 +-
 arch/sparc/mm/srmmu.c                        |  4 +-
 arch/um/include/asm/pgalloc.h                |  4 +-
 arch/um/kernel/mem.c                         |  4 +-
 arch/unicore32/include/asm/pgalloc.h         |  4 +-
 arch/x86/Kconfig                             |  1 +
 arch/x86/include/asm/pgalloc.h               |  4 +-
 arch/x86/mm/pgtable.c                        |  4 +-
 arch/xtensa/include/asm/pgalloc.h            |  8 +--
 include/linux/mm.h                           | 13 ++--
 mm/huge_memory.c                             |  8 +--
 mm/kasan/kasan_init.c                        |  2 +-
 mm/memory.c                                  | 17 +++--
 mm/migrate.c                                 |  2 +-
 mm/mremap.c                                  | 67 +++++++++++++++++++-
 mm/userfaultfd.c                             |  2 +-
 virt/kvm/arm/mmu.c                           |  2 +-
 47 files changed, 169 insertions(+), 147 deletions(-)

-- 
2.19.0.605.g01d371f741-goog
