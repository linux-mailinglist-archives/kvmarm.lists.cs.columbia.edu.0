Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 140103AB74F
	for <lists+kvmarm@lfdr.de>; Thu, 17 Jun 2021 17:20:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7BBBD4A51D;
	Thu, 17 Jun 2021 11:20:45 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.911
X-Spam-Level: 
X-Spam-Status: No, score=0.911 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001,
	T_DKIM_INVALID=0.01, URIBL_RED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QhTLl28tWoLl; Thu, 17 Jun 2021 11:20:45 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4B3574AEF8;
	Thu, 17 Jun 2021 11:20:44 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 6CE804A3B4
 for <kvmarm@lists.cs.columbia.edu>; Thu, 17 Jun 2021 11:20:42 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GZ3mSd7vnRGE for <kvmarm@lists.cs.columbia.edu>;
 Thu, 17 Jun 2021 11:20:41 -0400 (EDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com
 [209.85.167.52])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 4EADC40874
 for <kvmarm@lists.cs.columbia.edu>; Thu, 17 Jun 2021 11:20:41 -0400 (EDT)
Received: by mail-lf1-f52.google.com with SMTP id f30so11197225lfj.1
 for <kvmarm@lists.cs.columbia.edu>; Thu, 17 Jun 2021 08:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5nxSzCxRIGKeYpvFJwHnokf+lsLXzTQKnVZehNuKBfY=;
 b=v73zJk16lVzUG7QbbkRkacwK3TUPJGuBDYnlw6a7OPjaXiFoy/Tg1SF7o+pP2VkjgQ
 GCw+WkjfIQ3l6iS90jFkDddYRWl54Fy+YMR/OLBaPnT1q7EH0oEDgCPwHFRf8oPp7gGh
 W7Ec4TAFYCyuNTidERQalF9VJ9rhnKCIZeBncU5P/7WoHZpOenVDVwlRJezyVC2NtJ6Y
 vboZ+Jh+7e1OhUpnKBfhBMPZL2co2cGDoDioEPRVmBRw4+jEILLh2FWrKa/OxCOxZ34S
 /rw7UTqce3bTc65+uzu2YO9pLXUzTgYikYTMftRKjr074dSbh8dedXtXArBgTf7VXUpm
 YOvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5nxSzCxRIGKeYpvFJwHnokf+lsLXzTQKnVZehNuKBfY=;
 b=HtDFWHZHgQnUidHpP9pYxAUmHOQS3UfTXANZEx7htAxD+QhM2qYPtkmeAAsFFw1mSi
 kw1qOT6Fvuyw4YBPaqhMTkId56nGYoy/RPEwvSdyqgJMs5XDfbAGnV1LcdINohGYdWac
 8TsFF16c4ge8riNW4JyEk8IHErjY/3tVg4vFg8RtHh3CikVsngYDRpwQe+JKMaG/0aWH
 6eQ0uPwlFQYun0hn+uylprVm7n92Z0xarJB6Rdx/X7LRGogplBJxagiCvFNA5qF3NaFI
 T/noh6pjjThfQw3KtCAZ55eKWao4I8ftd88LL7R3X3OgzW/1NgsRKyxUYHjEdI6LA8U6
 tt+Q==
X-Gm-Message-State: AOAM533LPv+QMEkmzzZ9yCr2XVgrM6fImH6ak94rAKGPeHCTnXsVBnjU
 OcxX+Kks0HIyuAe05YBRWKRTr7uHFKtF7yA0Ia18wQ==
X-Google-Smtp-Source: ABdhPJxKKizWi/fGNn+9wpt69Ewj2CzuOybJdiyg4e/t3EuxZUFb779j6T3WEp//mVN3Ae7BamP0hcGF5jtDYBl/+0Y=
X-Received: by 2002:a05:6512:3ea:: with SMTP id
 n10mr4392667lfq.178.1623943239558; 
 Thu, 17 Jun 2021 08:20:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210617044146.2667540-1-jingzhangos@google.com>
 <20210617044146.2667540-4-jingzhangos@google.com> <YMrkGZzPrt0jA1iP@kroah.com>
In-Reply-To: <YMrkGZzPrt0jA1iP@kroah.com>
From: Jing Zhang <jingzhangos@google.com>
Date: Thu, 17 Jun 2021 10:20:27 -0500
Message-ID: <CAAdAUtik0Yw+4=4Ld-DJSokNzvdpa-tsxkqAdBCAb-C=uS0-sA@mail.gmail.com>
Subject: Re: [PATCH v10 3/5] KVM: stats: Add documentation for binary
 statistics interface
To: Greg KH <gregkh@linuxfoundation.org>
Cc: KVM <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>,
 Paul Mackerras <paulus@ozlabs.org>,
 Linuxkselftest <linux-kselftest@vger.kernel.org>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, Will Deacon <will@kernel.org>,
 KVMARM <kvmarm@lists.cs.columbia.edu>,
 Emanuele Giuseppe Esposito <eesposit@redhat.com>,
 LinuxS390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.ibm.com>,
 Marc Zyngier <maz@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 David Rientjes <rientjes@google.com>, KVMPPC <kvm-ppc@vger.kernel.org>,
 Krish Sadhukhan <krish.sadhukhan@oracle.com>,
 David Matlack <dmatlack@google.com>, Jim Mattson <jmattson@google.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Sean Christopherson <seanjc@google.com>, Cornelia Huck <cohuck@redhat.com>,
 Peter Shier <pshier@google.com>, LinuxMIPS <linux-mips@vger.kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>
X-BeenThere: kvmarm@lists.cs.columbia.edu
X-Mailman-Version: 2.1.14
Precedence: list
List-Id: Where KVM/ARM decisions are made <kvmarm.lists.cs.columbia.edu>
List-Unsubscribe: <https://lists.cs.columbia.edu/mailman/options/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=unsubscribe>
List-Archive: <https://lists.cs.columbia.edu/pipermail/kvmarm>
List-Post: <mailto:kvmarm@lists.cs.columbia.edu>
List-Help: <mailto:kvmarm-request@lists.cs.columbia.edu?subject=help>
List-Subscribe: <https://lists.cs.columbia.edu/mailman/listinfo/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

Hi Greg,

On Thu, Jun 17, 2021 at 12:56 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Jun 17, 2021 at 04:41:44AM +0000, Jing Zhang wrote:
> > +     struct kvm_stats_desc {
> > +             __u32 flags;
> > +             __s16 exponent;
> > +             __u16 size;
> > +             __u32 offset;
> > +             __u32 unused;
> > +             char name[0];
> > +     };
>
> <snip>
>
> > +The ``unused`` fields are reserved for future support for other types of
> > +statistics data, like log/linear histogram.
>
> you HAVE to set unused to 0 for now, otherwise userspace does not know
> it is unused, right?  And then, really it is "used", so why not just say
> that now?  It's tricky, but you have to get this right now otherwise you
> can never use it in the future.
>
Sure, will do that.
> > +The ``name`` field points to the name string of the statistics data. The name
>
> It is not a pointer, it is the data itself.
>
Will fix it.
> > +string starts at the end of ``struct kvm_stats_desc``.
> > +The maximum length (including trailing '\0') is indicated by ``name_size``
> > +in ``struct kvm_stats_header``.
>
> I thought we were replacing [0] arrays with [], are you sure you should
> be declaring this as [0]?  Same for all structures in this document (and
> code).
>
The reason to declare it as [0] is to have the flexibility to change the maximum
length of KVM stats name. For now, the max len is  defined as 48, which can
be read from the header. Then the userspace can get the length of descriptor by
adding sizeof(struct_kvm_stats_desc) + 48. Whenever the max len is changed
in KVM, the userspace would not have to update code to reflect that.
However, if we are OK to restrict the maximum KVM stats' length to 48
(or any other
number), we can just declear it with [] instead of [0].
> thanks,
>
> greg k-h

Thanks,
Jing
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
