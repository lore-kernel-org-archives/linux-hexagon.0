From: Richard Kuo <rkuo@codeaurora.org>
Subject: Re: Hexagon-setup: Combine four seq_printf() calls into one call in
 show_cpuinfo()
Date: Tue, 25 Oct 2016 16:37:35 -0500
Message-ID: <20161025213735.GA27715@codeaurora.org>
References: <c19c69d5-600c-f08b-f448-0420e677db63@users.sourceforge.net>
 <alpine.DEB.2.10.1610210918420.3212@hadrien>
 <e9daa136-c6ab-2f96-3d20-6e143fa1170b@users.sourceforge.net>
 <20161021154624.maiwbgjmzlzhin2l@thunk.org>
 <48d54097-6be3-d39d-2af9-d4ad90c3c417@users.sourceforge.net>
 <20161021175317.nnb2keq7m3phwgbv@thunk.org>
 <20c77dde-a1a0-8383-f344-a6f788af68d9@users.sourceforge.net>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1477431462;
        bh=u3f30TvGgM1CqemrjxaPM7B6YPCdIZjcxlUAlJsvA/g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bqj4rBQ0AsONpxRAVRG1CjUncq7udby4uaI1SbVjJ6MiQvIX4ih+mul+qwnk864qT
         gtXSGt7YRHlQ7pMXcjaS0mCqTPnd8MDFudErqxMF0tKWloqc1dAjolISYfs3ukr4f0
         z7ot3FqGZdi8nQ/CVvnsZBn7eHU93Fqa8Dru9vOY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1477431457;
        bh=u3f30TvGgM1CqemrjxaPM7B6YPCdIZjcxlUAlJsvA/g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fZY25pkjfh9kVAK+1THcdeGTpbtmaPjmcxK1gInnZ3HnpXFk2CXDvWkrizDHII3/a
         RLs7mh+IqZhghnQZTqeIkxI34nJHS5waflY8P6buKXzd4H+9z0ukZLpgiX82Bs0oat
         s1uLuyJqcoJJ2Wzie8aq7HLVZ16IweMCwek9wqrY=
Content-Disposition: inline
In-Reply-To: <20c77dde-a1a0-8383-f344-a6f788af68d9@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: Theodore Ts'o <tytso@mit.edu>, Julia Lawall <julia.lawall@lip6.fr>, linux-hexagon@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

I wrote it the original way precisely for readability; it's easier, at least
to me, to read and modify the old way.

However, in my development version I happen to be printing a lot more
stuff.

To test, I collapsed 18 of my seq_printf's into one call.  That reduced the
function size by a couple hundred bytes.  (Didn't do anything for the final
kernel size though.)

If it makes things better, even if only slightly, doesn't introduce bugs, 
and doesn't otherwise violate any other rules (correct me if I'm wrong), I
would personally accept the minor readability tradeoff in this case.


Acked-by: Richard Kuo <rkuo@codeaurora.org>



On Fri, Oct 21, 2016 at 08:50:11PM +0200, SF Markus Elfring wrote:
> > When the author of the semantic patch language is telling you to stand down,
> 
> The collaboration evolved between Julia and me during the years somehow.
> Different software development opinions occur then as usual.
> Further opinions from contributors like you can eventually show variations
> between disagreement and acceptance.
> 
> 
> > and you still want to try to argue for blind application of patches,
> 
> I guess that we have got different views about "blind" tries.
> 
> 
> > we have a really big problem.
> 
> I hope that potential communication difficulties can still be resolved.
> 
> 
> > Especially when some of your patches have actually introduced bugs.
> 
> I assume that these incidents could be clarified further, couldn't they?
> 
> Regards,
> Markus
> --
> To unsubscribe from this list: send the line "unsubscribe linux-hexagon" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
