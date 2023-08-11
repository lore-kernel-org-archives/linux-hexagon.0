From: Vineet Gupta <vgupta@kernel.org>
Subject: Re: [PATCH 16/17] [RFC] arch: turn -Wmissing-prototypes off
 conditionally
Date: Fri, 11 Aug 2023 11:25:37 -0700
Message-ID: <2cb4c584-fb4a-5781-f74d-902416749ed4@kernel.org>
References: <20230810141947.1236730-1-arnd@kernel.org>
 <20230810141947.1236730-17-arnd@kernel.org>
 <CAJF2gTRdbXOEBNPN14y_ZUwBJ15qBG929BDspk0sqPo2sn=L-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691778341;
        bh=J5jMJWNe5mxefsfwYpjk94ucCqvKpHDhJ2RLFLWPzvE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Gz052yUM1XxLU/RgjOg34wukKcdr6mu92lg4kRvftL4t+JLmQb8r1u1actRxxcApf
         PjHlYbsUsWZ+bKIaVoc7rK52krQ4OWPLnEH93QFvpXRAbigb2wSUKLi45TU/nHEb+C
         Jwl9WfjJwBcQjOTRkBTLUH9d7syGI0QxxJS6cM+B4sNpqdMSIJVnJTbcdGoGTSTSlZ
         PeS+VwcMkTke4e6X7PE/F46DP+6t406NKl/ODdSSnHdrM9/eHvIbao7c9+sM5I0D9t
         oKICESQTk0FrGQu3zXtHyOu/DayhYLn0OVumhMRyOLFfjSFrRZmIStkSQKluPFVJ8K
         zZHStULYsZlMQ==
Content-Language: en-US
In-Reply-To: <CAJF2gTRdbXOEBNPN14y_ZUwBJ15qBG929BDspk0sqPo2sn=L-Q@mail.gmail.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Guo Ren <guoren@kernel.org>, Arnd Bergmann <arnd@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Brian Cain <bcain@quicinc.com>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>, Stafford Horne <shorne@gmail.com>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>, Chris


On 8/10/23 19:33, Guo Ren wrote:
> Thx, Arnd, I will clean them up for the csky part.

Likewise, I'll clean up ARC errors this weekend !
It seems most of therm are in the category you mentioned. Non static but 
only used by asm code.

Thx,
-Vineet
