From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v5 26/33] nios2: Convert __pte_free_tlb() to use ptdescs
Date: Tue, 27 Jun 2023 12:14:00 -0700
Message-ID: <b6a5753b-8874-6465-f690-094ee753e038@roeck-us.net>
References: <20230622205745.79707-1-vishal.moola@gmail.com>
 <20230622205745.79707-27-vishal.moola@gmail.com>
 <13bab37c-0f0a-431a-8b67-4379bf4dc541@roeck-us.net>
 <CAOzc2px6VutRkMUTn+M5LFLf1YbRVZFgJ=q7StaApwYRxUWqQA@mail.gmail.com>
 <cc954b15-63ab-9d9f-2d37-1aea78b7f65f@roeck-us.net>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687893243; x=1690485243;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=kvHLvhv1Vboi73O1yp/Tlc9InhlPe7nOe1kq7T+MFRo=;
        b=bM9Je+tOekLovPkvT+/l7nbya5CmvdUQjXrADEm1UMcV4/Dft3yRiRDI0ZDflduo0a
         eCCHc/eGgHA3aTnPLKW75ZP3+msGkQAgAajr0fU475B6t9dnUbkeGDGaGhTQuEs9G8Em
         fP/NIDTeV8LmgxO8Ql0wOGFl7SgfrLikcvULFnS16kiPfzK7oAB1YpIUgqh/lMxpHyod
         tqWpPiE4/bUvsjhZfVbvFSWKmV4p5zoSojTJH1B4PXJkJ5GFHQt4ps0dwXEGoW/rFJ5j
         7OEFRkR/4WYv521gDAmtenL688/6yjI/zD/BFplexhWDCjqz/HwvAM7QaYSh0oWP3Dui
         ALeA==
Sender: Guenter Roeck <groeck7@gmail.com>
Content-Language: en-US
In-Reply-To: <cc954b15-63ab-9d9f-2d37-1aea78b7f65f@roeck-us.net>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
To: Vishal Moola <vishal.moola@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Hugh Dickins <hughd@google.com>, Dinh Nguyen <dinguyen@kernel.org>, Mike Rapoport <rppt@kernel.org>

On 6/27/23 12:10, Guenter Roeck wrote:
> On 6/27/23 10:42, Vishal Moola wrote:
>> On Mon, Jun 26, 2023 at 10:47=E2=80=AFPM Guenter Roeck <linux@roeck-us.n=
et> wrote:
>>>
>>> On Thu, Jun 22, 2023 at 01:57:38PM -0700, Vishal Moola (Oracle) wrote:
>>>> Part of the conversions to replace pgtable constructor/destructors with
>>>> ptdesc equivalents.
>>>>
>>>> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
>>>> Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
>>>
>>> This patch causes all nios2 builds to fail.
>>
>> It looks like you tried to apply this patch on its own. This patch depen=
ds
>> on patches 01-12 of this patchset to compile properly. I've cross-compil=
ed
>> this architecture and it worked, but let me know if something fails
>> when its applied on top of those patches (or the rest of the patchset).
>=20
>=20
> No, I did not try to apply this patch on its own. I tried to build yester=
day's
> pending-fixes branch of linux-next.
>=20

A quick check shows that the build fails with next-20230627. See log below.

Guenter

---

$ git describe
next-20230627
$ git describe --match 'v*'
v6.4-12601-g53cdf865f90b

Build reference: v6.4-12601-g53cdf865f90b
Compiler version: nios2-linux-gcc (GCC) 11.4.0
Assembler version: GNU assembler (GNU Binutils) 2.40

Building nios2:allnoconfig ... failed
--------------
Error log:
<stdin>:1519:2: warning: #warning syscall clone3 not implemented [-Wcpp]
In file included from mm/memory.c:86:
mm/memory.c: In function 'free_pte_range':
arch/nios2/include/asm/pgalloc.h:33:17: error: implicit declaration of func=
tion 'pagetable_pte_dtor'; did you mean 'pgtable_pte_page_dtor'? [-Werror=
=3Dimplicit-function-declaration]
    33 |                 pagetable_pte_dtor(page_ptdesc(pte));             =
      \
       |                 ^~~~~~~~~~~~~~~~~~
include/asm-generic/tlb.h:666:17: note: in expansion of macro '__pte_free_t=
lb'
   666 |                 __pte_free_tlb(tlb, ptep, address);             \
       |                 ^~~~~~~~~~~~~~
mm/memory.c:194:9: note: in expansion of macro 'pte_free_tlb'
   194 |         pte_free_tlb(tlb, token, addr);
       |         ^~~~~~~~~~~~
arch/nios2/include/asm/pgalloc.h:33:36: error: implicit declaration of func=
tion 'page_ptdesc' [-Werror=3Dimplicit-function-declaration]
    33 |                 pagetable_pte_dtor(page_ptdesc(pte));             =
      \
       |                                    ^~~~~~~~~~~
include/asm-generic/tlb.h:666:17: note: in expansion of macro '__pte_free_t=
lb'
   666 |                 __pte_free_tlb(tlb, ptep, address);             \
       |                 ^~~~~~~~~~~~~~
mm/memory.c:194:9: note: in expansion of macro 'pte_free_tlb'
   194 |         pte_free_tlb(tlb, token, addr);
       |         ^~~~~~~~~~~~
arch/nios2/include/asm/pgalloc.h:34:17: error: implicit declaration of func=
tion 'tlb_remove_page_ptdesc'; did you mean 'tlb_remove_page_size'? [-Werro=
r=3Dimplicit-function-declaration]
    34 |                 tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));=
      \
       |                 ^~~~~~~~~~~~~~~~~~~~~~
include/asm-generic/tlb.h:666:17: note: in expansion of macro '__pte_free_t=
lb'
   666 |                 __pte_free_tlb(tlb, ptep, address);             \
       |                 ^~~~~~~~~~~~~~
mm/memory.c:194:9: note: in expansion of macro 'pte_free_tlb'
   194 |         pte_free_tlb(tlb, token, addr);
       |         ^~~~~~~~~~~~
cc1: some warnings being treated as errors
make[3]: *** [scripts/Makefile.build:243: mm/memory.o] Error 1
make[3]: *** Waiting for unfinished jobs....
make[2]: *** [scripts/Makefile.build:477: mm] Error 2
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [Makefile:2022: .] Error 2
make: *** [Makefile:226: __sub-make] Error 2
