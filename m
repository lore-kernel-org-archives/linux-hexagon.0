From: Helge Deller <deller@gmx.de>
Subject: Re: [PATCH v4 3/4] arch/*/io.h: remove ioremap_uc in some
 architectures
Date: Fri, 10 Mar 2023 22:14:03 +0100
Message-ID: <5f807b94-9169-3120-9329-611e4031c665@gmx.de>
References: <20230308130710.368085-1-bhe@redhat.com>
 <20230308130710.368085-4-bhe@redhat.com>
 <20230309143621.GA12350@alpha.franken.de> <ZAqLuNrPng9i0rZV@MiWiFi-R3L-srv>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1678482846; i=deller@gmx.de;
        bh=We4tVJ9aX8WWemGD0IA7ECCoCjcoMbMpuqwmPkvAqqQ=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Fs4lLH/bAjI990hi6oAWHu3X3VrWy3tjXXuztt8y3REr7ICCFlamg5QYRmGvdM5Fu
         GHSdyxSyJiY888XV0gZzrBL+Ko5rb5YOLxATE1ZhCv2jOVEuRFWO909M3OGH7pZr75
         k0x1rtJuDFogkmQlkVKFnxI/8XDlOeh3utjdYYwg90cukCxJmgql8lC5VeeReKk9QX
         fpFXPD5UFxkVgQKl7Ww4eBAG0ICrOSt7bZ1rAVEPfR7OotYtt2ULvJZvjm9MJVFWyF
         A/U4OnCaEf9lpDimlHnv1cYE6G8TPQ4rU04hN4/EYRVECsXbxTRryC4MsIRusiEKd9
         mcYHsMUH8P6MA==
Content-Language: en-US
In-Reply-To: <ZAqLuNrPng9i0rZV@MiWiFi-R3L-srv>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Baoquan He <bhe@redhat.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, arnd@arndb.de, mpe@ellerman.id.au, geert@linux-m68k.org, mcgrof@kernel.org, hch@infradead.org, linux-alpha@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org

On 3/10/23 02:45, Baoquan He wrote:
> On 03/09/23 at 03:36pm, Thomas Bogendoerfer wrote:
>> On Wed, Mar 08, 2023 at 09:07:09PM +0800, Baoquan He wrote:
>>> ioremap_uc() is only meaningful on old x86-32 systems with the PAT
>>> extension, and on ia64 with its slightly unconventional ioremap()
>>> behavior. So remove the ioremap_uc() definition in architecutures
>>> other than x86 and ia64. These architectures all have asm-generic/io.h
>>> included and will have the default ioremap_uc() definition which
>>> returns NULL.
>>>
>>> This changes the existing behaviour, while no need to worry about
>>> any breakage because in the only callsite of ioremap_uc(), code
>>> has been adjusted to eliminate the impact. Please see
>>> atyfb_setup_generic() of drivers/video/fbdev/aty/atyfb_base.c.
>>>
>>> If any new invocation of ioremap_uc() need be added, please consider
>>> using ioremap() intead or adding a ARCH specific version if necessary.
>>>
>>> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
>>> Signed-off-by: Baoquan He <bhe@redhat.com>
>>> Cc: linux-alpha@vger.kernel.org
>>> Cc: linux-hexagon@vger.kernel.org
>>> Cc: linux-m68k@lists.linux-m68k.org
>>> Cc: linux-mips@vger.kernel.org
>>> Cc: linux-parisc@vger.kernel.org
>>> Cc: linuxppc-dev@lists.ozlabs.org
>>> Cc: linux-sh@vger.kernel.org
>>> Cc: sparclinux@vger.kernel.org
>>> ---
>>>   Documentation/driver-api/device-io.rst | 9 +++++----
>>>   arch/alpha/include/asm/io.h            | 1 -
>>>   arch/hexagon/include/asm/io.h          | 3 ---
>>>   arch/m68k/include/asm/kmap.h           | 1 -
>>>   arch/mips/include/asm/io.h             | 1 -
>>>   arch/parisc/include/asm/io.h           | 2 --
>>>   arch/powerpc/include/asm/io.h          | 1 -
>>>   arch/sh/include/asm/io.h               | 2 --
>>>   arch/sparc/include/asm/io_64.h         | 1 -
>>>   9 files changed, 5 insertions(+), 16 deletions(-)
>>
>> this doesn't apply to v6.3-rc1... what tree is this based on ?
>
> Sorry, I forgot mentioning this in cover letter. This series is
> followup of below patchset, so it's on top of below patchset and based
> on v6.3-rc1.
>
> https://lore.kernel.org/all/20230301034247.136007-1-bhe@redhat.com/T/#u
> [PATCH v5 00/17] mm: ioremap:  Convert architectures to take GENERIC_IOR=
EMAP way

I've applied both patch series on top of v6.3-rc1 and
tested it with success on the parisc platform (32- and 64-bit kernel).

You may add to both patch series:

Acked-by: Helge Deller <deller@gmx.de>  # parisc

Thank you!
Helge
