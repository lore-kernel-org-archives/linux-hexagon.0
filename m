From: patchwork-bot+linux-riscv@kernel.org
Subject: Re: [PATCH mm-unstable v1 00/26] mm: support
 __HAVE_ARCH_PTE_SWP_EXCLUSIVE on all architectures with swap PTEs
Date: Tue, 28 Feb 2023 21:11:17 +0000
Message-ID: <167761867725.10135.3611718470427113262.git-patchwork-notify@kernel.org>
References: <20230113171026.582290-1-david@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-m68k-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677618677;
        bh=hQNwE+IEUbKQvI91yvljJosaVP7JCZ7+8bppV3cOFbg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=EWCQE/HQjrWuM9JLi5n8h88COIVDC0Dwj8Ls7hxDeYr4SIALkO/qqCk/UGcAvWK5o
         c02+sh/QcUi/6bE0ILdbEb/C+A8GV+CJaLo8WfaGxJWgLFvkSK7vL/E7uokCa4MOxg
         ngdg3jXiJrkGUm98gEQXAgu/dxa50c+7WgMlmDgNw1PpnJ2oFrWoeU4ingGh4tZ7R7
         NCLLPqaZ1Zn4rnovGjIPX8BlJ6CPAfDs1vwTGYqI9oMCtgbAk9Bh8oF1Q3q6KxteX4
         j5u6Jm2tA55Z1q6NEJRkgLy4vCcaaRiYhIH8qBVhYl9/Ucn2GR4gvjnvRg/iSe5UV4
         UdVCGz5UeLKDg==
In-Reply-To: <20230113171026.582290-1-david@redhat.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: David Hildenbrand <david@redhat.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, hughd@google.com, jhubbard@nvidia.com, jgg@nvidia.com, rppt@linux.ibm.com, shy828301@gmail.com, vbabka@suse.cz, namit@vmware.com, aarcange@redhat.com, peterx@redhat.com, linux-mm@kvack.org, x86@kernel.org, linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, linux-xtensa@l

Hello:

This series was applied to riscv/linux.git (for-next)
by Andrew Morton <akpm@linux-foundation.org>:

On Fri, 13 Jan 2023 18:10:00 +0100 you wrote:
> This is the follow-up on [1]:
> 	[PATCH v2 0/8] mm: COW fixes part 3: reliable GUP R/W FOLL_GET of
> 	anonymous pages
> 
> After we implemented __HAVE_ARCH_PTE_SWP_EXCLUSIVE on most prominent
> enterprise architectures, implement __HAVE_ARCH_PTE_SWP_EXCLUSIVE on all
> remaining architectures that support swap PTEs.
> 
> [...]

Here is the summary with links:
  - [mm-unstable,v1,01/26] mm/debug_vm_pgtable: more pte_swp_exclusive() sanity checks
    (no matching commit)
  - [mm-unstable,v1,02/26] alpha/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
    (no matching commit)
  - [mm-unstable,v1,03/26] arc/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
    (no matching commit)
  - [mm-unstable,v1,04/26] arm/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
    (no matching commit)
  - [mm-unstable,v1,05/26] csky/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
    (no matching commit)
  - [mm-unstable,v1,06/26] hexagon/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
    (no matching commit)
  - [mm-unstable,v1,07/26] ia64/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
    (no matching commit)
  - [mm-unstable,v1,08/26] loongarch/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
    (no matching commit)
  - [mm-unstable,v1,09/26] m68k/mm: remove dummy __swp definitions for nommu
    (no matching commit)
  - [mm-unstable,v1,10/26] m68k/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
    (no matching commit)
  - [mm-unstable,v1,11/26] microblaze/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
    (no matching commit)
  - [mm-unstable,v1,12/26] mips/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
    (no matching commit)
  - [mm-unstable,v1,13/26] nios2/mm: refactor swap PTE layout
    (no matching commit)
  - [mm-unstable,v1,14/26] nios2/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
    (no matching commit)
  - [mm-unstable,v1,15/26] openrisc/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
    (no matching commit)
  - [mm-unstable,v1,16/26] parisc/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
    (no matching commit)
  - [mm-unstable,v1,17/26] powerpc/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE on 32bit book3s
    (no matching commit)
  - [mm-unstable,v1,18/26] powerpc/nohash/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
    (no matching commit)
  - [mm-unstable,v1,19/26] riscv/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
    https://git.kernel.org/riscv/c/51a1007d4113
  - [mm-unstable,v1,20/26] sh/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
    (no matching commit)
  - [mm-unstable,v1,21/26] sparc/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE on 32bit
    (no matching commit)
  - [mm-unstable,v1,22/26] sparc/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE on 64bit
    (no matching commit)
  - [mm-unstable,v1,23/26] um/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
    (no matching commit)
  - [mm-unstable,v1,24/26] x86/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE also on 32bit
    (no matching commit)
  - [mm-unstable,v1,25/26] xtensa/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
    (no matching commit)
  - [mm-unstable,v1,26/26] mm: remove __HAVE_ARCH_PTE_SWP_EXCLUSIVE
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


