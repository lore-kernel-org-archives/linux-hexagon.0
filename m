From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v6 13/41] mm: Make pte_mkwrite() take a VMA
Date: Mon, 20 Feb 2023 12:00:46 +1100
Message-ID: <875ybxywu9.fsf@mpe.ellerman.id.au>
References: <20230218211433.26859-1-rick.p.edgecombe@intel.com>
 <20230218211433.26859-14-rick.p.edgecombe@intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-alpha-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1676854853;
        bh=F/BA55hncJJcUXKiAlKImZaWKF9J7v8lLnKr9dq21p4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=XslnKyUEjBPQ1U1pxlZfaOackH5Uc53v2LGKi4H/fZCzwS12mRxSKUo5Y0d1NKeZn
         awyroz/jmv/ppUpYp1TDhtbm3Xr2UbxbQ7SLm7HpIZR367un5O+1m6RO8MFNGLc4tN
         bOsgsJ/QSRuN9qLOaQNEAnGHLCgJYRh2AmA+hh1/q0GxiYmMbgWuXckkgvhyXESi3z
         pkyDk+R2FxF/Bbq8WxwITYwB8LWISeRkdVED0wYKG14B7OppQx/VBH6ejWIfX4nrhf
         +DPFJJxnIwj6xY4eD5/CyK6ZQt6qJeWIa8XOq0dKk/I3y+LAhnFdM5gYPtu4P26I4l
         sm8Hu7By7kuYg==
In-Reply-To: <20230218211433.26859-14-rick.p.edgecombe@intel.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="windows-1252"
To: x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle>
Cc: rick.p.edgecombe@intel.com, linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, Michal Simek <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>, linux-mips@vger.kernel.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, xen-devel@lists.xenproject.org

Rick Edgecombe <rick.p.edgecombe@intel.com> writes:
> The x86 Control-flow Enforcement Technology (CET) feature includes a new
> type of memory called shadow stack. This shadow stack memory has some
> unusual properties, which requires some core mm changes to function
> properly.
...
> ---
> Hi Non-x86 Arch=E2=80=99s,
>
> x86 has a feature that allows for the creation of a special type of
> writable memory (shadow stack) that is only writable in limited specific
> ways. Previously, changes were proposed to core MM code to teach it to
> decide when to create normally writable memory or the special shadow stack
> writable memory, but David Hildenbrand suggested[0] to change
> pXX_mkwrite() to take a VMA, so awareness of shadow stack memory can be
> moved into x86 code.
>
> Since pXX_mkwrite() is defined in every arch, it requires some tree-wide
> changes. So that is why you are seeing some patches out of a big x86
> series pop up in your arch mailing list. There is no functional change.
> After this refactor, the shadow stack series goes on to use the arch
> helpers to push shadow stack memory details inside arch/x86.
...
> ---
>  Documentation/mm/arch_pgtable_helpers.rst    |  9 ++++++---
>  arch/alpha/include/asm/pgtable.h             |  6 +++++-
>  arch/arc/include/asm/hugepage.h              |  2 +-
>  arch/arc/include/asm/pgtable-bits-arcv2.h    |  7 ++++++-
>  arch/arm/include/asm/pgtable-3level.h        |  7 ++++++-
>  arch/arm/include/asm/pgtable.h               |  2 +-
>  arch/arm64/include/asm/pgtable.h             |  4 ++--
>  arch/csky/include/asm/pgtable.h              |  2 +-
>  arch/hexagon/include/asm/pgtable.h           |  2 +-
>  arch/ia64/include/asm/pgtable.h              |  2 +-
>  arch/loongarch/include/asm/pgtable.h         |  4 ++--
>  arch/m68k/include/asm/mcf_pgtable.h          |  2 +-
>  arch/m68k/include/asm/motorola_pgtable.h     |  6 +++++-
>  arch/m68k/include/asm/sun3_pgtable.h         |  6 +++++-
>  arch/microblaze/include/asm/pgtable.h        |  2 +-
>  arch/mips/include/asm/pgtable.h              |  6 +++---
>  arch/nios2/include/asm/pgtable.h             |  2 +-
>  arch/openrisc/include/asm/pgtable.h          |  2 +-
>  arch/parisc/include/asm/pgtable.h            |  6 +++++-
>  arch/powerpc/include/asm/book3s/32/pgtable.h |  2 +-
>  arch/powerpc/include/asm/book3s/64/pgtable.h |  4 ++--
>  arch/powerpc/include/asm/nohash/32/pgtable.h |  2 +-
>  arch/powerpc/include/asm/nohash/32/pte-8xx.h |  2 +-
>  arch/powerpc/include/asm/nohash/64/pgtable.h |  2 +-

Looks like you discovered the joys of ppc's at-least 5 different MMU
implementations, sorry :)

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers
