Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C5838E10A;
	Fri, 27 Feb 2026 09:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772185105; cv=none; b=FCG1z61wwQ+cXJOt/P600w0GWy44OVDs5DpU4DlNJ6Crvhl4XD3vSH2pE6Sd1x/stosExR9BLu7t9D5jeAjNcwxZJZ4g1DZLqth3hAMg3fTMDIOvtbeedDLayGIxM320QkWkAowrIOmefjz+K6P5onL/8KjD4LBhpiNmSFXju9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772185105; c=relaxed/simple;
	bh=FEW0hpIoi3auojzyGSZ+t87DvcLxl5nD6oUjVn6CqC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ltYMFkvt+uloWlVYM+9ycxFbh2ZxCKmqkKlXucINfEdgJ7bEk8TkcZZMzyZ69o49VUl9lxwkW7PCT3Pq3wODsu6/NRO7wXKLrLCyMQFpfQNisC0Jd6o2PerPTrKMUUB+qW2sGHOp7GMYkVDt/JaIKVR36NnDgKYSo9Hqud5rthQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G6wxppZu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NKxY/owD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G6wxppZu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NKxY/owD"
Date: Fri, 27 Feb 2026 10:38:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772185102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UZWcOv5dS4W7eNWKDIFkwGDaCp2cjomVrR87OGzmqnY=;
	b=G6wxppZuK3yXUT9z8pgJh/NB81h/iKjcmRcAaZ26Ei2m7Uyz60oE7pM04fVNdxqWcFaNJ7
	1zwCtJLuAKECSaVuDoWy8CveRcRuszoDytif8Q8uFtxebL3fl7vUmcEmKvwTquUkTNfx43
	Tp9ZLNM9yxB1k34fQOuKGuxEUo6RPzPvj2NJjIhCIhiR1uO1cxay9qkqnwUaBbd95e69ZB
	70VKThLDD3hDxOEz2DrTvx+am+eLfF6pVx5HcxJ//kvT5fkeKmR0S/gbaAwgSABBqOunzn
	QQzgmgQwzjwIQWMcEltG4Q4puRpAwb+4wOOuHfYhMNMk9BnMxLzEZB4ED/zeMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772185102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UZWcOv5dS4W7eNWKDIFkwGDaCp2cjomVrR87OGzmqnY=;
	b=NKxY/owDRVF9Gk/iW4li/rk9zl7xers1oe80gbLzD3/IUNgWvs9i9zRmpHeKeHTFZEH9Rk
	MbtZoAC5L0JtpaAQ==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, Brian Cain <bcain@kernel.org>, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org
Subject: Re: [PATCH 0/9] kbuild: uapi: remove usage of toolchain headers
Message-ID: <20260227103449-a526a376-153c-4f86-bfc9-2eddbdde58fd@linutronix.de>
References: <20260227-kbuild-uapi-libc-v1-0-c17de0d19776@weissschuh.net>
 <67674db4-4da2-484c-be59-c97144083179@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <67674db4-4da2-484c-be59-c97144083179@app.fastmail.com>

On Fri, Feb 27, 2026 at 10:18:41AM +0100, Arnd Bergmann wrote:
> On Fri, Feb 27, 2026, at 07:37, Thomas Weiﬂschuh wrote:
> > Currently the test compilation of some UAPI headers requires a toolchain
> > libc headers. Remove that dependency.
> >
> > Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> 
> Nice work!
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> I had toyed around with a similar series, using a slightly different
> approach of always using the in-kernel nolibc headers, and making
> those compile across all architectures (using empty stubs for those
> that are missing syscall entry functions).
> 
> I don't care much which way we do this as long as we can build test
> the headers, but I wonder what your reason was for picking this
> approach over the other.

My goal is to reduce the reliance of the UAPI headers on libc ones.
Hopefully we can remove libc usages from the UAPI headers and then also
drop the compatibility bits from the stub headers. If we use the full nolibc
the message to UAPI authors would not be clear and new dependencies may be
introduced again.


Thomas
