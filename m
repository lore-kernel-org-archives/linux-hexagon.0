From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] arch: configuration, deleting 'CONFIG_BUG' since always
 need it.
Date: Thu, 23 May 2013 11:12:56 +0200
Message-ID: <CAMuHMdWez-j1Maa3BD7ucmzv0_zFJnChERQiHFmkCaZUzG0_AA@mail.gmail.com>
References: <519DCBEF.3090208@asianux.com>
 <CAMuHMdU7QuzgmWCH145p8PVebBzPo8DBAvbY+0AZa2cmGXmRHw@mail.gmail.com>
 <20130523090534.GJ18614@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
 h=mime-version:sender:in-reply-to:references:date
 :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
 bh=32Qf0PNxnh03Ogo3BClMzpPI+UdxMGr7LJ0Xwcp2ffY=;
 b=yC/xJW18UsXP7Tuj3CN75mlV/fyzwMd05t7Yi1lFRk/JWi1sltLXH1bU8z9+H4d+M0
 T0icqqrbc7pOKN2UscEz/XGsYL5/w8C7WgpUNzXKCFkHs/GE+Wk5Kx9OFXkA9ZwrtwRf
 vVCigtJ/v3x+oKjq/hds6cwT/faL1Tj7kj+E3f+LVDGH2vE96zGRSMHGlV/gyHa20e40
 +Iav+spKDGe6LZCwElGfLq41xMsvmXCK9p4QaZv5LQMIKlK5qHiF0hz99oquoUC54DKt
 rxvNv58OGbeoWu0q9K/nJ7ZTVAFxB6zw/bLIHDqV/MTZNP0hLq84/ADVZKkojINas7AM
 slkA==
In-Reply-To: <20130523090534.GJ18614@n2100.arm.linux.org.uk>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Catalin Marinas <Catalin.Marinas@arm.com>, Linux-sh list <linux-sh@vger.kernel.org>, Chen Gang <gang.chen@asianux.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "paulus@samba.org" <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, Michel Lespinasse <walken@google.com>, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Linux-Arch <linux-arch@vger.kernel.org>, linux-s390@vger.kernel.org, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Weinberger <richard@nod.at>, Helge Deller <deller@gmx.de>, the arch/x86 maintainers <x86@kernel.org>, "James E.J. Bottomley" <jejb@parisc-linux.org>, "mingo@redhat.com" <mingo@redhat.com>, Frederic Weisbecker <fweisbec@gmail.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, =?UTF-8?Q?H=C3=A5vard_Skinnemoen?= <hskinnemoen@gmail.com>, Serge Hallyn <serge.hallyn@canonical.com>

On Thu, May 23, 2013 at 11:05 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, May 23, 2013 at 10:40:29AM +0200, Geert Uytterhoeven wrote:
>> On Thu, May 23, 2013 at 9:57 AM, Chen Gang <gang.chen@asianux.com> wrote:
>> > -config BUG
>> > -       bool "BUG() support" if EXPERT
>> > -       default y
>> > -       help
>> > -          Disabling this option eliminates support for BUG and WARN, reducing
>> > -          the size of your kernel image and potentially quietly ignoring
>> > -          numerous fatal conditions. You should only consider disabling this
>> > -          option for embedded systems with no facilities for reporting errors.
>> > -          Just say Y.
>>
>> ... It's about reducing memory size on devices where you can't show bug or
>> warning messages.
>
> And turning off CONFIG_BUG causes lots of warning messages at compile time
> about functions which are returning nothing which shouldn't.
>
> The problem is: trying to fix that _will_ mean the result is a larger
> kernel than if you just do the usual arch-implemented thing of placing
> an defined faulting instruction at the BUG() site - which defeats the
> purpose of turning off CONFIG_BUG.

Is __builtin_unreachable() working well these days?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
