From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: Removing architectures without upstream gcc support
Date: Fri, 9 Mar 2018 15:33:47 +0100
Message-ID: <CAK8P3a1v3XuwhRacboXK7AZQD32JMsc3bY74KdchEWSYVd0y7g@mail.gmail.com>
References: <23bf54ca.a08c.1620b20bd53.Coremail.gxt@pku.edu.cn>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=L+OTGcqqZmDBo7GM0ehNseTieGvz9snpyX9MXeVZVbk=;
        b=GlajNuStqwjske0CuUzsQIpXbtHBPR7Jtx9eMRkylhLUdZhQMdGvqTQFg0KeF96YFw
         QiODKJE3EAy0EeVgYKzI96HEHVfeSoc64oABCKHI/V7wfYcDdPxOZPzCuE97D1wsbdX6
         oUsC7+rdzkDNYg3mYROxyH0Ob7NqmCc2n1NkU6Li9Uw9VO4S6lS0Wzdv03NBPDP/tHzo
         aMUVzy0UN1+SQnPof7XY5pr31K8AyW7Pfq8Uj1xGdr8Wxr4pQ93oTky1E8U727lAY1gw
         Sq28WMZQbDVhFkYQAiL6i3ZMLAX6Zc4t6xImxg6lyAJnQENNSg8W/yyxx7Vtw3L1d3C4
         livA==
In-Reply-To: <23bf54ca.a08c.1620b20bd53.Coremail.gxt@pku.edu.cn>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guan Xuetao <gxt@pku.edu.cn>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Richard Kuo <rkuo@codeaurora.org>, linux-hexagon <linux-hexagon@vger.kernel.org>, Chen Liqin <liqin.linux@gmail.com>, Lennox Wu <lennox.wu@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Guenter Roeck <linux@roeck-us.net>, Al Viro <viro@zeniv.linux.org.uk>, James Hogan <jhogan@kernel.org>, linux-metag <linux-metag@vger.kernel.org>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, David Howells <dhowells@redhat.com>, openrisc@lists.librecores.org

On Fri, Mar 9, 2018 at 3:18 PM, Guan Xuetao <gxt@pku.edu.cn> wrote:
> Since mprc.pku.edu.cn is blocked, I use this email account to send the email again.
>
>> * unicore32 was a research project at Peking University with a SoC
>>   based on the Intel PXA design. No gcc source code has ever been
>>   published, the only toolchain available is a set of binaries that
>> include
>>   a gcc-4.4 compiler. The project page at
>>   http://mprc.pku.edu.cn/~guanxuetao/linux/ has a TODO list that has
>>   not been modified since 2011. The maintainer still Acks patches
>>   and has last sent a pull request in 2014 and last sent a patch of
>>   his own in 2012 when the project appears to have stalled.
>>   I would suggest removing this one.
>>
> Hi, Arnd.
> I am really sorry to reply so late, since I seldom use this email account
> in recent years. I will add my new email account to related bits.
>
> Let me clarify the status of UniCore. It's a real cpu-core product,
> integrated into PKUnity SoC, and sold in a large amount of embedded boxes,
> such as cloud terminals and set top boxes. Surely, we still use the port
> internally and keep doing developments in other projects. So, I really
> appreciate having unicore32 port in the tree.

Ok, thanks for your reply, I'm dropping my removal patch then and will
try to document the current status better.

Can you send me a patch to the MAINTAINERS file update to the email
address? If you have no other patches at this point, I'll add that to my
patch series so at least you can be reached more easily.

> As to gnu toolchain of UniCore, I have already discussed it in my group,
> and I'll do my best to propel it forward.

Thanks, that would be very helpful!

     Arnd
