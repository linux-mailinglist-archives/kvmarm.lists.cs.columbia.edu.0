Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 333993AB7BC
	for <lists+kvmarm@lfdr.de>; Thu, 17 Jun 2021 17:41:35 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BBBF44B098;
	Thu, 17 Jun 2021 11:41:34 -0400 (EDT)
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
	with ESMTP id xqqSqIfgMtk8; Thu, 17 Jun 2021 11:41:34 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 567BE4B09B;
	Thu, 17 Jun 2021 11:41:33 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 5E6B54B097
 for <kvmarm@lists.cs.columbia.edu>; Thu, 17 Jun 2021 11:41:32 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7kkMK3aXe3KQ for <kvmarm@lists.cs.columbia.edu>;
 Thu, 17 Jun 2021 11:41:31 -0400 (EDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com
 [209.85.167.54])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id D9138407F1
 for <kvmarm@lists.cs.columbia.edu>; Thu, 17 Jun 2021 11:41:30 -0400 (EDT)
Received: by mail-lf1-f54.google.com with SMTP id a1so11046575lfr.12
 for <kvmarm@lists.cs.columbia.edu>; Thu, 17 Jun 2021 08:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cepd0f27LneqXg9yBZHquT1TDjoAFG7wSdTqKz5kG5c=;
 b=IUSnDUK9i0mIwBz9JQbaBXrKZmOgldZIjMDFGl85ekFKWOFe6+aAN2KZCUz4DtUbGb
 2/9d7g+L6BNkQyPP/wGGk4S9wXzAYWYjjHCq0AdBpGkrrxKOrsdL0wDgkVNrjnKnoLHi
 PANDSFQZuFwucGI4X+9Zpbg61MKctBKlW+KzHb1hiI2W8poSTNZJXqfHDLhTB+hpF4ZI
 fPb0FdUfUYOyDQRt6TwFYiUAA2g638XcmoIXrY4o6OG7KtCBC2wPkNKRXagmDNZoQYjF
 jzWOxyde8gvTwEVNHKMKxoY7qwEtBxdUJw7M+QJoKW8b8tMtDMoScorXPyDI5NoYPQzi
 aRow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cepd0f27LneqXg9yBZHquT1TDjoAFG7wSdTqKz5kG5c=;
 b=O/ilub61jd+kLQmGUi3WW9+LL7PAAIc11oUqD7XpbMQiFGDEoMorCwHUNrvke6awBd
 DgICp6xAwwzTVCpl34bVhr/EQqgAn9dGY9886oewG8xUK79ryVfF74k4EAqau1y5RL4+
 EqsiI0odDyZNfXVuaeCMEuSurq54396XXRALiwmRF4S6bVmmNXVV5LE9deHSk3obz5Y5
 gUkUbDPi+SKZDVRfQ+VI0Gv+wfTHP6BBxmUYje+DYZFl8Gh0ezFnkobcUnSPtEDfSTqb
 EL103dshKQ0QffOU5y40pxWSEeVGBwNqyzovXPXZoLfx4Xi6BZEONT+bnzRjbx9DiYbm
 1aoA==
X-Gm-Message-State: AOAM530pTOcpGC+bD5w2d8SyFSvvefnU+SAQMfRo3MQQ53IaJ937g8kO
 VbiKKsK0QFG1YAYjCxy9G8iJ1yW6GufA7Vh4acBPXA==
X-Google-Smtp-Source: ABdhPJzu2tzjzuZ8k5ySeP0mq3iRjrOvN2faIeDOwnxQdGPjMXrDRcTmdXSiP7LIP2dlbEgm9N+pQT1taHciiCQM81I=
X-Received: by 2002:a05:6512:39ca:: with SMTP id
 k10mr4537655lfu.473.1623944489036; 
 Thu, 17 Jun 2021 08:41:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210617044146.2667540-1-jingzhangos@google.com>
 <20210617044146.2667540-4-jingzhangos@google.com> <YMrmDwfmBPdZqLjC@kroah.com>
In-Reply-To: <YMrmDwfmBPdZqLjC@kroah.com>
From: Jing Zhang <jingzhangos@google.com>
Date: Thu, 17 Jun 2021 10:41:17 -0500
Message-ID: <CAAdAUtg8rTO+9xrGSaOyviTBAkX9253qnXNujAUhc99nEJb2yw@mail.gmail.com>
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

On Thu, Jun 17, 2021 at 1:05 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Jun 17, 2021 at 04:41:44AM +0000, Jing Zhang wrote:
> > +The file descriptor can be used to read VM/vCPU statistics data in binary
> > +format. The file data is organized into three blocks as below:
> > ++-------------+
> > +|   Header    |
> > ++-------------+
> > +| Descriptors |
> > ++-------------+
> > +| Stats Data  |
> > ++-------------+
> > +
> > +The Header block is always at the start of the file. It is only needed to be
> > +read one time for the lifetime of the file descriptor.
> > +It is in the form of ``struct kvm_stats_header`` as below::
> > +
> > +     #define KVM_STATS_ID_MAXLEN             64
> > +
> > +     struct kvm_stats_header {
> > +             __u32 name_size;
> > +             __u32 count;
> > +             __u32 desc_offset;
> > +             __u32 data_offset;
> > +             char id[0];
> > +     };
>
> So you have no idea the size of the whole header when reading it?  That
> feels odd, are you sure it's not needed?
>
We do know the size when reading it, it is sizeof(struct kvm_stats_header) +
KVM_STATS_ID_MAXLEN.
I think we need to change "char id[0]" to "char id[KVM_STATS_ID_MAXLEN]" here.
Since it is not like the name field in the descriptor, the max id
string's length is fixed.
> > +The ``id`` field is identification for the corresponding KVM statistics. For
> > +VM statistics, it is in the form of "kvm-{kvm pid}", like "kvm-12345". For
> > +VCPU statistics, it is in the form of "kvm-{kvm pid}/vcpu-{vcpu id}", like
> > +"kvm-12345/vcpu-12".
>
> Why do you have "name_size" but not "id_size"?
Because we know that the max length of id is less than 64, that's why we
have KVM_STATS_ID_MAXLEN exported to userspace.
But for KVM stats name, we are not sure about the max length in  the future.
The maximum length for KVM stats is defined as 48 in KVM for now, but it is
possible that it might need to be increased to 64 or larger.
>
> And is this a \0 terminated string?  If so, please state it here.
>
Will do.
> And what is the max size of this string?
>
> And again, should it be [], not [0]?
As stated in previous comments, there are pros and cons to choose between
[] and [0].
>
> Will the header be padded out to any specific byte boundry
> (4/8/32/whatever) before the other headers?
>
No. For every architecture, there is only one header for VM and one header
for VCPU.
> > +
> > +The ``name_size`` field is the size (byte) of the statistics name string
>
> s/byte/in bytes/
>
Will do.
> > +(including trailing '\0') appended to the end of every statistics descriptor.
> > +
> > +The ``count`` field is the number of statistics.
> > +
> > +The ``desc_offset`` field is the offset of the Descriptors block from the start
> > +of the file indicated by the file descriptor.
> > +
> > +The ``data_offset`` field is the offset of the Stats Data block from the start
> > +of the file indicated by the file descriptor.
> > +
> > +The Descriptors block is only needed to be read once for the lifetime of the
> > +file descriptor. It is an array of ``struct kvm_stats_desc`` as shown in
> > +below code block::
> > +
> > +     #define KVM_STATS_TYPE_SHIFT            0
> > +     #define KVM_STATS_TYPE_MASK             (0xF << KVM_STATS_TYPE_SHIFT)
> > +     #define KVM_STATS_TYPE_CUMULATIVE       (0x0 << KVM_STATS_TYPE_SHIFT)
> > +     #define KVM_STATS_TYPE_INSTANT          (0x1 << KVM_STATS_TYPE_SHIFT)
> > +     #define KVM_STATS_TYPE_MAX              KVM_STATS_TYPE_INSTANT
> > +
> > +     #define KVM_STATS_UNIT_SHIFT            4
> > +     #define KVM_STATS_UNIT_MASK             (0xF << KVM_STATS_UNIT_SHIFT)
> > +     #define KVM_STATS_UNIT_NONE             (0x0 << KVM_STATS_UNIT_SHIFT)
> > +     #define KVM_STATS_UNIT_BYTES            (0x1 << KVM_STATS_UNIT_SHIFT)
> > +     #define KVM_STATS_UNIT_SECONDS          (0x2 << KVM_STATS_UNIT_SHIFT)
> > +     #define KVM_STATS_UNIT_CYCLES           (0x3 << KVM_STATS_UNIT_SHIFT)
> > +     #define KVM_STATS_UNIT_MAX              KVM_STATS_UNIT_CYCLES
> > +
> > +     #define KVM_STATS_BASE_SHIFT            8
> > +     #define KVM_STATS_BASE_MASK             (0xF << KVM_STATS_BASE_SHIFT)
> > +     #define KVM_STATS_BASE_POW10            (0x0 << KVM_STATS_BASE_SHIFT)
> > +     #define KVM_STATS_BASE_POW2             (0x1 << KVM_STATS_BASE_SHIFT)
> > +     #define KVM_STATS_BASE_MAX              KVM_STATS_BASE_POW2
> > +
> > +     struct kvm_stats_desc {
> > +             __u32 flags;
> > +             __s16 exponent;
> > +             __u16 size;
> > +             __u32 offset;
> > +             __u32 unused;
> > +             char name[0];
> > +     };
> > +
> > +The ``flags`` field contains the type and unit of the statistics data described
> > +by this descriptor. The following flags are supported:
> > +
> > +Bits 0-3 of ``flags`` encode the type:
> > +  * ``KVM_STATS_TYPE_CUMULATIVE``
> > +    The statistics data is cumulative. The value of data can only be increased.
> > +    Most of the counters used in KVM are of this type.
> > +    The corresponding ``count`` field for this type is always 1.
> > +  * ``KVM_STATS_TYPE_INSTANT``
> > +    The statistics data is instantaneous. Its value can be increased or
> > +    decreased. This type is usually used as a measurement of some resources,
> > +    like the number of dirty pages, the number of large pages, etc.
> > +    The corresponding ``count`` field for this type is always 1.
> > +
> > +Bits 4-7 of ``flags`` encode the unit:
> > +  * ``KVM_STATS_UNIT_NONE``
> > +    There is no unit for the value of statistics data. This usually means that
> > +    the value is a simple counter of an event.
> > +  * ``KVM_STATS_UNIT_BYTES``
> > +    It indicates that the statistics data is used to measure memory size, in the
> > +    unit of Byte, KiByte, MiByte, GiByte, etc. The unit of the data is
> > +    determined by the ``exponent`` field in the descriptor. The
> > +    ``KVM_STATS_BASE_POW2`` flag is valid in this case. The unit of the data is
> > +    determined by ``pow(2, exponent)``. For example, if value is 10,
> > +    ``exponent`` is 20, which means the unit of statistics data is MiByte, we
> > +    can get the statistics data in the unit of Byte by
> > +    ``value * pow(2, exponent) = 10 * pow(2, 20) = 10 MiByte`` which is
> > +    10 * 1024 * 1024 Bytes.
> > +  * ``KVM_STATS_UNIT_SECONDS``
> > +    It indicates that the statistics data is used to measure time/latency, in
> > +    the unit of nanosecond, microsecond, millisecond and second. The unit of the
> > +    data is determined by the ``exponent`` field in the descriptor. The
> > +    ``KVM_STATS_BASE_POW10`` flag is valid in this case. The unit of the data
> > +    is determined by ``pow(10, exponent)``. For example, if value is 2000000,
> > +    ``exponent`` is -6, which means the unit of statistics data is microsecond,
> > +    we can get the statistics data in the unit of second by
> > +    ``value * pow(10, exponent) = 2000000 * pow(10, -6) = 2 seconds``.
> > +  * ``KVM_STATS_UNIT_CYCLES``
> > +    It indicates that the statistics data is used to measure CPU clock cycles.
> > +    The ``KVM_STATS_BASE_POW10`` flag is valid in this case. For example, if
> > +    value is 200, ``exponent`` is 4, we can get the number of CPU clock cycles
> > +    by ``value * pow(10, exponent) = 200 * pow(10, 4) = 2000000``.
> > +
> > +Bits 8-11 of ``flags`` encode the base:
> > +  * ``KVM_STATS_BASE_POW10``
> > +    The scale is based on power of 10. It is used for measurement of time and
> > +    CPU clock cycles.
> > +  * ``KVM_STATS_BASE_POW2``
> > +    The scale is based on power of 2. It is used for measurement of memory size.
> > +
> > +The ``exponent`` field is the scale of corresponding statistics data. For
> > +example, if the unit is ``KVM_STATS_UNIT_BYTES``, the base is
> > +``KVM_STATS_BASE_POW2``, the ``exponent`` is 10, then we know that the real
> > +unit of the statistics data is KBytes a.k.a pow(2, 10) = 1024 bytes.
>
> Might also want to show a negative example here for exponent, like you
> show above for time.
>
>
Will do.
> > +
> > +The ``size`` field is the number of values (u64) of this statistics data. Its
> > +value is usually 1 for most of simple statistics.
>
> What does "u64" mean here?
It means the type of value is unsigned 64 bit. Will clarify this.
>
> thanks,
>
> greg k-h

Thanks,
Jing
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
