From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 05/17] arm: Convert to GENERIC_CMDLINE
Date: Fri, 26 Mar 2021 12:22:04 -0600
Message-ID: <CAL_JsqJOFHmfRNAXgm6Gbe3qTUwnUTroxPzPmmLJUN7ciM2z9g@mail.gmail.com>
References: <cover.1616765869.git.christophe.leroy@csgroup.eu>
 <7362e4f6a5f5b79e6ad3fd3cec3183a4a283f7fc.1616765870.git.christophe.leroy@csgroup.eu>
 <CAL_Jsq+LF-s5K4Jwd5jCHrU8271L5WCiGb0tR7aTUa8ddHF1YQ@mail.gmail.com>
 <c18ef8f7-8e79-a9d3-3853-f8b992a4fc93@csgroup.eu>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1616782938;
 bh=jLGR+NyehSUNZVl5kh+mHpluJzlAfSJXFMkJ5QFHPLQ=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=FGNMBA2S+sqoHCfdgN2xPFLdvY7w1ubfGycnYplAm5Xuh33eTfteivyAovekbWA9w
 yfld9bMxHjPtk6Hhklpu7oYZIbdFL1ljaGBXqC5JDt9yKBlTX7kAx1myFZ7wuAQTTU
 jVdlWWeH+3FguNaGmIau3X7NuPSKeRLNaH0udlAHqHLaTI2Nh59I0ILOAppKs8o8/D
 19qHEC4fCaQI1gejM6rW9sLEbEJ8sx1EuiN8eQS9UBjNdK2v5TM+H9geJCe0fg2Uua
 hTXju+20flSq1dpCUtji3RjvYCP8L0pwpr+4Ldr1Bi1ZJpawqdb9WedZVTTF9eqZAI
 +O7oIbfohruuw==
In-Reply-To: <c18ef8f7-8e79-a9d3-3853-f8b992a4fc93@csgroup.eu>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org>
Content-Type: text/plain; charset="utf-8"
To: Christophe Leroy <christophe.leroy@csgroup.eu>, Nicolas Pitre <nico@fluxnic.net>
Cc: "open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>, devicetree@vger.kernel.org, microblaze <monstr@monstr.eu>, Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>, linux-xtensa@linux-xtensa.org, SH-Linux <linux-sh@vger.kernel.org>, Will Deacon <will@kernel.org>, X86 ML <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, nios2 <ley.foon.tan@intel.com>, "open list:MIPS" <linux-mips@vger.kernel.org>, Openrisc <openrisc@lists.librecores.org>, linux-hexagon@vger.kernel.org, sparclinux <sparclinux@vger.kernel.org>, linux-riscv <linux-riscv@lists.infradead.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Daniel Walker <danielwa@cisco.com>

+Nico who added the line in question.

On Fri, Mar 26, 2021 at 9:50 AM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
>
>
> Le 26/03/2021 =C3=A0 16:47, Rob Herring a =C3=A9crit :
> > On Fri, Mar 26, 2021 at 7:44 AM Christophe Leroy
> > <christophe.leroy@csgroup.eu> wrote:
> >>
> >> This converts the architecture to GENERIC_CMDLINE.
> >>
> >> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> >> ---
> >>   arch/arm/Kconfig              | 38 +--------------------------------=
--
> >>   arch/arm/kernel/atags_parse.c | 15 +++++---------
> >>   2 files changed, 6 insertions(+), 47 deletions(-)
> >>
> >> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> >> index 5da96f5df48f..67bc75f2da81 100644
> >> --- a/arch/arm/Kconfig
> >> +++ b/arch/arm/Kconfig
> >> @@ -50,6 +50,7 @@ config ARM
> >>          select GENERIC_ARCH_TOPOLOGY if ARM_CPU_TOPOLOGY
> >>          select GENERIC_ATOMIC64 if CPU_V7M || CPU_V6 || !CPU_32v6K ||=
 !AEABI
> >>          select GENERIC_CLOCKEVENTS_BROADCAST if SMP
> >> +       select GENERIC_CMDLINE if ATAGS
> >
> > Don't we need this enabled for !ATAGS (i.e. DT boot)?
> >
> > Can we always enable GENERIC_CMDLINE for OF_EARLY_FLATTREE?
> >
>
> Don't know.
>
> Today ARM has:
>
> choice
>         prompt "Kernel command line type" if CMDLINE !=3D ""
>         default CMDLINE_FROM_BOOTLOADER
>         depends on ATAGS

I think that's a mistake. In a DT only case (no ATAGS), we'll get
different behaviour (in fdt.c) depending if CONFIG_ATAGS is enabled or
not. Note that at the time (2012) the above was added, the DT code
only supported CONFIG_CMDLINE and CONFIG_CMDLINE_FORCE.
CONFIG_CMDLINE_EXTEND was only added in 2016. And that has different
behavior for ATAGS vs. DT. In summary, it's a mess. We should drop the
depends either before this patch or just as part of this patch IMO.
I'd go with the latter given CONFIG_ATAGS is default y and enabled for
common configs. Without that, it looks like CONFIG_CMDLINE disappears
from menuconfig for at91_dt_defconfig.

Also, I think this code should be refactored a bit to eliminate
default_command_line. Instead, we should just save a pointer to the
ATAGS command line string, and then call cmdline_build here instead of
doing the extra copy:

        /* parse_early_param needs a boot_command_line */
        strlcpy(boot_command_line, from, COMMAND_LINE_SIZE);

Rob
