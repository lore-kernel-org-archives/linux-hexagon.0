From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: Removing architectures without upstream gcc support
Date: Wed, 28 Feb 2018 09:37:09 +0100
Message-ID: <CAK8P3a13VDiH8+NG00p5oM2j5KMNU3JnCUurFn6EdJgztZsKHg@mail.gmail.com>
References: <CAK8P3a2-6YwRR3j7J78fVHSvDpq8Kf4wRj6d9mnGgAxgkYypxg@mail.gmail.com>
 <20180222191758.GB5180@codeaurora.org> <CAK8P3a3r=3wDtqV5feLUT-hOkE+9yWOLjLVm+nejqdaN7MtMFw@mail.gmail.com>
 <20180228020631.GB3780@codeaurora.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=zkJjgyQ/2Yk/oAqNjCAgdXkTnHnN7gZJPqMNnO0Qvl4=;
        b=S/44Rm6jf55ClR5hU/I2d8mfS/KmeX+p4DAQIXTn8Q7vDC6T56hSuyJqsp9y245FLA
         7VNiaHJXvnAgBNZ4IWqVcRugeW6/4oq7xH5QqNsupM0ZdOWgPqeNoFh5Vpg9YVMpiytf
         Lr5+JC79x0dpBdLbkT6KouZazE2W6x7Yq+UabnclNnaRueOAdzlpoaAXOmk8/NTB0X7Z
         UHWoPHtMnOrP+QOQ6IpGU0O3SesZlyomQgv60/eiKveGN65uzm9b8Z82tSQqSVe1VuB9
         jrFl+GpnrhtQvE5HWpTa0M+x871NsrDxM7rzGTxY2BwhnY63+mvdhZtweRqgxqnPTGfu
         KYdQ==
In-Reply-To: <20180228020631.GB3780@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>, Chen Liqin <liqin.linux@gmail.com>, Lennox Wu <lennox.wu@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Guenter Roeck <linux@roeck-us.net>, Al Viro <viro@zeniv.linux.org.uk>, James Hogan <jhogan@kernel.org>, "open list:METAG ARCHITECTURE" <linux-metag@vger.kernel.org>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, openrisc@lists.librecores.org, David Howells <dhowells@redhat.com>

On Wed, Feb 28, 2018 at 3:06 AM, Richard Kuo <rkuo@codeaurora.org> wrote:
> On Thu, Feb 22, 2018 at 11:43:10PM +0100, Arnd Bergmann wrote:
>> - How do I build an llvm based toolchain for Hexagon? Do I need patches
>>   on top of the llvm-6 release branch? Where can I find the corresponding
>>   binutils-2.30 sources?
>
> Just to follow up on this, the closest thing right now to compile the kernel
> for Hexagon is the toolchain included with the Hexagon SDK.  However, the
> linker will fail because of something in the kernel build process that
> I think produces empty sections, which that linker can't handle.  A newer
> linker can handle it, but that's not scheduled to be released until much later
> this year.
>
> That's actually the closest option currently.  I tried the upstream source
> but it seems to lack some specific patches to support kernel compilation,
> so I will need to chase those down.

Thanks for trying it out. Can you point me to the sources? I tried downloading
a Hexagon SDK when I first looked at it, but only got a huge chunk of binary
java files and gave up before finding the llvm patches.

       Arnd
