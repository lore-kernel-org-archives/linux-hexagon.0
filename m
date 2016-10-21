From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH] Hexagon-setup: Combine four seq_printf() calls into one
 call in show_cpuinfo()
Date: Fri, 21 Oct 2016 11:46:24 -0400
Message-ID: <20161021154624.maiwbgjmzlzhin2l@thunk.org>
References: <c19c69d5-600c-f08b-f448-0420e677db63@users.sourceforge.net>
 <alpine.DEB.2.10.1610210918420.3212@hadrien>
 <e9daa136-c6ab-2f96-3d20-6e143fa1170b@users.sourceforge.net>
Mime-Version: 1.0
Return-path: <kernel-janitors-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org; s=ef5046eb;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=E7fHr2JCr1ndb9lMACBhtLi31v67LQG1lXr319BvX+4=;
        b=US4C3LMgyIvmItq+KJugrHllsIPzg3Hw7qYntrbQ2lxhoOHK5vBaP8ylr8+JtB5Hq6GqwW2Epmvth7kQN4jh0GfhzEqHnvHwPdzh7QY29YlEoB2G0kjOzZ4McHqJXnztMi7Orm5HY23VMFgT8ZylUZBFdzsiROdIX7tAdQwI2Nc=;
Content-Disposition: inline
In-Reply-To: <e9daa136-c6ab-2f96-3d20-6e143fa1170b@users.sourceforge.net>
Sender: kernel-janitors-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: Julia Lawall <julia.lawall@lip6.fr>, linux-hexagon@vger.kernel.org, Richard Kuo <rkuo@codeaurora.org>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

On Fri, Oct 21, 2016 at 11:00:22AM +0200, SF Markus Elfring wrote:
> 
> > It is harder to see how the arguments fit into the strings
> > and it is harder to see where the strings end and the arguments begin.
> 
> Is it really so difficult to interpret the suggested construction
> of a single (and relatively small) format string?

It's not so difficult, so much as it makes things worse.  It's easier
the way it originally was.  It might be interesting to see if the
compiler could be taught to collapse the function calls, but (a) this
isn't performance critical, and (b) the number of bytes saved is
really tiny.  But at least if the compiler was doing the work, it
would at least deal with it everywhere.

					- Ted
