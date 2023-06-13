From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v9 01/42] mm: Rename arch pte_mkwrite()'s to pte_mkwrite_novma()
Date: Tue, 13 Jun 2023 09:19:32 +0200
Message-ID: <CAMuHMdX7K-9gXuOM3KkFieM_W2-Sbb3AVZ-sR65abRMdSBux5A@mail.gmail.com>
References: <20230613001108.3040476-1-rick.p.edgecombe@intel.com> <20230613001108.3040476-2-rick.p.edgecombe@intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-alpha-owner@vger.kernel.org>
In-Reply-To: <20230613001108.3040476-2-rick.p.edgecombe@intel.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="windows-1252"
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>

On Tue, Jun 13, 2023 at 2:13=E2=80=AFAM Rick Edgecombe
<rick.p.edgecombe@intel.com> wrote:
> The x86 Shadow stack feature includes a new type of memory called shadow
> stack. This shadow stack memory has some unusual properties, which requir=
es
> some core mm changes to function properly.
>
> One of these unusual properties is that shadow stack memory is writable,
> but only in limited ways. These limits are applied via a specific PTE
> bit combination. Nevertheless, the memory is writable, and core mm code
> will need to apply the writable permissions in the typical paths that
> call pte_mkwrite(). Future patches will make pte_mkwrite() take a VMA, so
> that the x86 implementation of it can know whether to create regular
> writable memory or shadow stack memory.
>
> But there are a couple of challenges to this. Modifying the signatures of
> each arch pte_mkwrite() implementation would be error prone because some
> are generated with macros and would need to be re-implemented. Also, some
> pte_mkwrite() callers operate on kernel memory without a VMA.
>
> So this can be done in a three step process. First pte_mkwrite() can be
> renamed to pte_mkwrite_novma() in each arch, with a generic pte_mkwrite()
> added that just calls pte_mkwrite_novma(). Next callers without a VMA can
> be moved to pte_mkwrite_novma(). And lastly, pte_mkwrite() and all callers
> can be changed to take/pass a VMA.
>
> Start the process by renaming pte_mkwrite() to pte_mkwrite_novma() and
> adding the pte_mkwrite() wrapper in linux/pgtable.h. Apply the same
> pattern for pmd_mkwrite(). Since not all archs have a pmd_mkwrite_novma(),
> create a new arch config HAS_HUGE_PAGE that can be used to tell if
> pmd_mkwrite() should be defined. Otherwise in the !HAS_HUGE_PAGE cases the
> compiler would not be able to find pmd_mkwrite_novma().
>
> No functional change.
>
> Cc: linux-doc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-alpha@vger.kernel.org
> Cc: linux-snps-arc@lists.infradead.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-csky@vger.kernel.org
> Cc: linux-hexagon@vger.kernel.org
> Cc: linux-ia64@vger.kernel.org
> Cc: loongarch@lists.linux.dev
> Cc: linux-m68k@lists.linux-m68k.org
> Cc: Michal Simek <monstr@monstr.eu>
> Cc: Dinh Nguyen <dinguyen@kernel.org>
> Cc: linux-mips@vger.kernel.org
> Cc: openrisc@lists.librecores.org
> Cc: linux-parisc@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-riscv@lists.infradead.org
> Cc: linux-s390@vger.kernel.org
> Cc: linux-sh@vger.kernel.org
> Cc: sparclinux@vger.kernel.org
> Cc: linux-um@lists.infradead.org
> Cc: linux-arch@vger.kernel.org
> Cc: linux-mm@kvack.org
> Suggested-by: Linus Torvalds <torvalds@linuxfoundation.org>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Link: https://lore.kernel.org/lkml/CAHk-=3DwiZjSu7c9sFYZb3q04108stgHff2wf=
bokGCCgW7riz+8Q@mail.gmail.com/

>  arch/m68k/include/asm/mcf_pgtable.h          |  2 +-
>  arch/m68k/include/asm/motorola_pgtable.h     |  2 +-
>  arch/m68k/include/asm/sun3_pgtable.h         |  2 +-

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
