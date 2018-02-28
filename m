From: Richard Kuo <rkuo@codeaurora.org>
Subject: Re: Removing architectures without upstream gcc support
Date: Tue, 27 Feb 2018 20:06:31 -0600
Message-ID: <20180228020631.GB3780@codeaurora.org>
References: <CAK8P3a2-6YwRR3j7J78fVHSvDpq8Kf4wRj6d9mnGgAxgkYypxg@mail.gmail.com>
 <20180222191758.GB5180@codeaurora.org>
 <CAK8P3a3r=3wDtqV5feLUT-hOkE+9yWOLjLVm+nejqdaN7MtMFw@mail.gmail.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1519783594;
        bh=tTOHj79JyRFLn/wKrzX3GS/fUneH0sRm6Fp22SALlqI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LrH/xO2AH46SJ7bkopxYi9ir7BaoP1zzRgYE/2ECOeprR6LuG7Uog43XnrW/1unOp
         olEvZor4+i6gZ9vwreaypyikOhuv5ftfdbNpBSJcCZRdPFsUm6YQ0TdCyPcWSDV/nQ
         B94+KzZiiSfqsU6qwJOdszupENRQPzLOpeM/CtoE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1519783594;
        bh=tTOHj79JyRFLn/wKrzX3GS/fUneH0sRm6Fp22SALlqI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LrH/xO2AH46SJ7bkopxYi9ir7BaoP1zzRgYE/2ECOeprR6LuG7Uog43XnrW/1unOp
         olEvZor4+i6gZ9vwreaypyikOhuv5ftfdbNpBSJcCZRdPFsUm6YQ0TdCyPcWSDV/nQ
         B94+KzZiiSfqsU6qwJOdszupENRQPzLOpeM/CtoE=
Content-Disposition: inline
In-Reply-To: <CAK8P3a3r=3wDtqV5feLUT-hOkE+9yWOLjLVm+nejqdaN7MtMFw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-hexagon@vger.kernel.org, Chen Liqin <liqin.linux@gmail.com>, Lennox Wu <lennox.wu@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Guenter Roeck <linux@roeck-us.net>, Al Viro <viro@zeniv.linux.org.uk>, James Hogan <jhogan@kernel.org>, linux-metag@vger.kernel.org, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, openrisc@lists.librecores.org, David Howells <dhowells@redhat.com>

On Thu, Feb 22, 2018 at 11:43:10PM +0100, Arnd Bergmann wrote:
> - How do I build an llvm based toolchain for Hexagon? Do I need patches
>   on top of the llvm-6 release branch? Where can I find the corresponding
>   binutils-2.30 sources?

Just to follow up on this, the closest thing right now to compile the kernel
for Hexagon is the toolchain included with the Hexagon SDK.  However, the 
linker will fail because of something in the kernel build process that
I think produces empty sections, which that linker can't handle.  A newer
linker can handle it, but that's not scheduled to be released until much later
this year.

That's actually the closest option currently.  I tried the upstream source
but it seems to lack some specific patches to support kernel compilation,
so I will need to chase those down.



Thanks,
Richard Kuo



-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
