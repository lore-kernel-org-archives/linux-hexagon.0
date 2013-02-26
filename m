From: Rob Landley <rob@landley.net>
Subject: Re: [DISCUSSION] Hexagon code inside kernel
Date: Tue, 26 Feb 2013 00:55:19 -0600
Message-ID: <1361861719.15497.0@driftwood>
References: <1163031361018389@web26d.yandex.ru>
	<1361593470.29465.17@driftwood> <1982671361708622@web15h.yandex.ru>
Mime-Version: 1.0
Content-Transfer-Encoding: 8BIT
Return-path: <linux-hexagon-owner@vger.kernel.org>
In-Reply-To: <1982671361708622@web15h.yandex.ru> (from cotulla@yandex.ua on
	Sun Feb 24 06:23:42 2013)
Content-Disposition: inline
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; delsp="Yes"; format="Flowed"
To: cotulla@yandex.ua
Cc: linux-hexagon@vger.kernel.org

On 02/24/2013 06:23:42 AM, cotulla@yandex.ua wrote:
> This is our current boot log:
> 
> http://pastie.org/private/slkvwbykfu4txqc1bq51q
> 
> However there are a lot of debug output.
> But at least it already reaches the end of user mode program which  
> consist from:
> 
>  puts("Hello from linux");
>  while (1);

I think I've missed chunks of this conversation: what are you booting  
it on?

(Wondering if I can get a test environment together. I haven't had one  
since I left qualcomm in 2010.)

Rob
