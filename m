From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: Re: Hexagon-setup: Combine four seq_printf() calls into one call in
 show_cpuinfo()
Date: Fri, 21 Oct 2016 19:33:30 +0200
Message-ID: <48d54097-6be3-d39d-2af9-d4ad90c3c417@users.sourceforge.net>
References: <c19c69d5-600c-f08b-f448-0420e677db63@users.sourceforge.net>
 <alpine.DEB.2.10.1610210918420.3212@hadrien>
 <e9daa136-c6ab-2f96-3d20-6e143fa1170b@users.sourceforge.net>
 <20161021154624.maiwbgjmzlzhin2l@thunk.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20161021154624.maiwbgjmzlzhin2l@thunk.org>
Sender: kernel-janitors-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Theodore Ts'o <tytso@mit.edu>, linux-hexagon@vger.kernel.org
Cc: Julia Lawall <julia.lawall@lip6.fr>, Richard Kuo <rkuo@codeaurora.org>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

>> Is it really so difficult to interpret the suggested construction
>> of a single (and relatively small) format string?
> 
> It's not so difficult, so much as it makes things worse.  It's easier
> the way it originally was.

Thanks for your view on this refactoring approach.


> It might be interesting to see if the compiler could be taught
> to collapse the function calls,

How does this wish fit to your previous rejection?


> but (a) this isn't performance critical,

This can be.


> and (b) the number of bytes saved is really tiny.

I imagine that the corresponding code and data size reduction could
be occasionally useful, couldn't it?


> But at least if the compiler was doing the work, it would at least deal with
> it everywhere.

I would find such an optimisation possibility also nice.

Can it become acceptable to achieve a similar effect by the application
of scripts for the semantic patch language in the meantime?

Regards,
Markus
