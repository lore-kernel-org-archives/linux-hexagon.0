From: Linas Vepstas <linasvepstas@gmail.com>
Subject: Re: [DISCUSSION] Hexagon code inside kernel
Date: Sat, 16 Feb 2013 11:33:11 -0600
Message-ID: <CAHrUA37eKrJXMQhgfNcZL5_Vdm0x=RGeH1q6ugWaJaCH7qZ-gg@mail.gmail.com>
References: <1093431360938494@web22d.yandex.ru> <CAHrUA364XES66kXhr0Gg1dh_MQBAS0+R8Q4x+EY3dgz6s=QRww@mail.gmail.com>
 <CAHrUA36mN-a6BTCp7DP-QgWA5ii86YbmpvZbBTnv__f0mqft6g@mail.gmail.com>
 <1433341360978513@web2h.yandex.ru> <CAHrUA3676_qeiAR7MXbYd6aFAgFpr6GC9k3Xz+wyvHk56ebXiA@mail.gmail.com>
 <1163031361018389@web26d.yandex.ru>
Reply-To: linasvepstas@gmail.com
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:reply-to:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=T501P4Vx86GAzsgNk+b2biGmzq+1ZNKAYcbTfmSzhQM=;
        b=0lG09tQTzJkpiMyyQgOW6zo3DvxV0VkLSOJYiUxuG0xV9Q73MsWbWoRj/9oyl0lTEw
         MGct1zGy8ffY50OXa46WsxGik1evxvqjASAStrm88RoAvZokIX1ERRgyq2LJj4kWecaC
         UMSP2NDVRXff5fsPsjhSUGFxnh6TDXuuCVfrlGwtq/lx4y1gaI9cxieSx+EOlD3mtQO4
         qyorDK2KmEtayEEvaklcOXdl1+x6s16WUiGVqmKEjgKIXbwwYpUhkBdF09HF3DJdUDuv
         dNvLVJ0fW1mjSdyyUHN6csX4ujwYyr5lPBLmHrLd2TM6g05rUTfo44d7Tdp2xzEYg8CN
         pxUA==
In-Reply-To: <1163031361018389@web26d.yandex.ru>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: cotulla@yandex.ua
Cc: linux-hexagon@vger.kernel.org

On 16 February 2013 06:39,  <cotulla@yandex.ua> wrote:
> In modern phones it's often locked from changes :(

!  I did not know that.  BTW, be aware that there are usually two
different qdsp's on there.  The smaller/older/slower one is running
the radio signal processing code and it is very locked down, as that
code is considered to be extremely valuable.  (Its also the one that
has total control over all the master interrupt masks, which not even
the ARM can over-ride).  I'm not sure, the radio processor might not
even be a qdsp6, it might be a qdsp5 or qdsp4, I never paid attention
to that.  But the point is:  if it seems like its locked down, make
sure you've got the right one, that there isn't another one sitting
there on the JTAG chain.

-- Linas
